//
//  PostPinViewController.swift
//  On The Map 1
//
//  Created by Manish raj(MR) on 16/12/21.
//

import Foundation
import UIKit
import CoreLocation

class PreviewMapViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var locationTextView: UITextView!
    
    @IBAction func findOnTheMapAction(_ sender: Any) {
        self.renderSpinner()
        self.getCoordinate(addressString: self.locationTextView.text, completionHandler: {coord, error in
            self.dismissSpinner()
            if (error != nil) {
                let alert = UIAlertController(title: "Error converting your location into geocode", message: nil, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            } else {
                var studentInfo = Userlocationsystem()
                studentInfo.latitude = coord.latitude
                studentInfo.longitude = coord.longitude
                studentInfo.mapString = self.locationTextView.text
                self.performSegue(withIdentifier: "findOnTheMapSegue", sender: studentInfo);
            }
        })
    }
    
    override func viewDidLoad() {
        self.locationTextView.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func getCoordinate(addressString : String,
                        completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let submitPinVC = segue.destination as! addlocationViewController;
        let studentInfo = sender as! Userlocationsystem;
        submitPinVC.studentInfo = studentInfo;
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

