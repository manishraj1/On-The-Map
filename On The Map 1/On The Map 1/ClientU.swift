//
//  UdacityAuthenticator.swift
//  On The Map 1
//
//  Created by Manish raj(MR) on 16/12/21.
//

import Foundation

final class ClientU {
    static let shared = ClientU()

    public func startSession(withUsername username: String, withPassword password: String, onSuccess: @escaping () -> (), onError: @escaping (String) -> ()) {
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
        let bodyJson: [String: Any] = ["udacity": ["username": username, "password": password]]
        let requestJsonData = try? JSONSerialization.data(withJSONObject: bodyJson)
        
        request.httpBody = requestJsonData
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            let range: Range = 5..<data!.count
            let newData = data?.subdata(in: range)
            
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: newData!, options: .allowFragments) as? [String:AnyObject]
                if let status = parsedResult!["status"] as? NSNumber {
                    if ((status ) != 200) {
                        onError((parsedResult!["error"] as! NSString).localizedUppercase)
                        return
                    }
                }
                if let uniqueKey = (parsedResult!["account"] as? [String: AnyObject])!["key"] as? String {
                    Udata.shared.userUniqueKey = uniqueKey
                    print("current user uniqueKey is ", uniqueKey)
                    onSuccess()
                }
            } catch {
                onError("Unexpected error happended")
                return
            }
        }
        task.resume()
    }
    
    public func deleteSession(onSuccess: @escaping () -> (), onError: @escaping (String) -> ()) {
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                onError(error!.localizedDescription)
                return
            }
            let range = 5..<data!.count
            let newData = data?.subdata(in: range) 
            print(String(data: newData!, encoding: .utf8)!)
            onSuccess()
        }
        task.resume()
    }
}
