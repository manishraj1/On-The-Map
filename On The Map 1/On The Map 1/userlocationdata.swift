//
//  Utils.swift
//  On The Map 1
//
//  Created by Manish raj(MR) on 16/12/21.
//

import Foundation
import UIKit

class userlocationdata {
    static func openUrl(urlToOpen: String) {
        let app = UIApplication.shared
        if (app.canOpenURL(URL(string: urlToOpen)!)) {
            app.open(URL(string: urlToOpen)!)
        }
    }
    enum ValidityType{
        case website
    }
    
    enum Regex: String{
        
        case website = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+?)?"
        
    }
    
    func isValid(_ validityType: ValidityType) -> Bool{
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityType{
        case .website:
            regex = Regex.website.rawValue
        }
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}

fileprivate var spinnerView: UIView?

extension UIViewController {
    // render a spinner view on top existing VC
    func renderSpinner() {
        spinnerView = UIView(frame: self.view.bounds)
        spinnerView!.backgroundColor = .white
        let spinner = UIActivityIndicatorView(style: .whiteLarge)
        spinner.color = .gray
        spinner.center = spinnerView!.center
        spinnerView!.addSubview(spinner)
        spinner.startAnimating()
        self.view.addSubview(spinnerView!)
    }
    
    func dismissSpinner() {
        spinnerView?.removeFromSuperview()
    }
}
