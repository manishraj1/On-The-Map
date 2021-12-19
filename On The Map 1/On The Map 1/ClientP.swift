//
//  ParseGateway.swift
//  On The Map 1
//
//  Created by Manish raj(MR) on 16/12/21.
//

import Foundation

final class ClientP {
    static let shared = ClientP()
    
    public func getStudentLocation(onSuccess: @escaping (Array<Userlocationsystem>) -> (), onError: @escaping (String) -> ()) {
        let request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation?limit=100&order=-updatedAt")!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                return
            }
            
            let parsedResult: [String: Any]!
            var locations: [Userlocationsystem] = []
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                for case let result in (parsedResult!["results"] as? Array<Any>)! {
                    if let studentLocaltion = Userlocationsystem(json: (result as? [String: Any])!) {
                        locations.append(studentLocaltion)
                    }
                }
                onSuccess(locations)
            } catch {
                onError("Could not parse the data as JSON: '\(String(describing: data))'")
                return
            }
        
        }
        task.resume()
    }
    
    public func postStudentLocation(firstName: String, lastName: String, addressString: String, mediaURL: String, latitude: Double, longitude: Double, onSuccess: @escaping () -> (), onError: @escaping (String) -> ()) -> Void {
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(addressString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}".data(using: .utf8)
    
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { 
                onError("post location failed, please try again")
            } else {
                print(response)
                onSuccess()
            }
        }
        task.resume()
    }
}
