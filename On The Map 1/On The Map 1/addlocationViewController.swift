//
//  SubmitPinViewController.swift
//  On The Map 1
//
//  Created by Manish raj(MR) on 16/12/21.
//

import Foundation
import UIKit
import MapKit

class addlocationViewController: UIViewController, UITextViewDelegate  {
    var studentInfo: Userlocationsystem?
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var linkToShare: UITextView!
    
    @IBAction func submitAction(_ sender: Any) {
        self.studentInfo?.mediaURL = linkToShare.text
        self.renderSpinner()
        ClientP.shared.postStudentLocation(firstName: "John", lastName: "Snow", addressString: self.studentInfo!.mapString, mediaURL: self.studentInfo!.mediaURL, latitude: self.studentInfo!.latitude, longitude: self.studentInfo!.longitude, onSuccess: self.onSuccess, onError: self.onError)
    }
    
    override func viewDidLoad() {
        self.linkToShare.delegate = self
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.studentInfo!.latitude, longitude: self.studentInfo!.longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        mapView.setRegion(region, animated: true)
        self.linkToShare.delegate = self
    }
    
    private func onError(_ error: String) {
        DispatchQueue.main.async {
            self.dismissSpinner()
            let alert = UIAlertController(title: "Somethign went wrong, please try again", message: error, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
    private func onSuccess() {
        DispatchQueue.main.async {
            self.dismissSpinner()
            self.performSegue(withIdentifier: "backToMapSegue", sender: nil)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
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


