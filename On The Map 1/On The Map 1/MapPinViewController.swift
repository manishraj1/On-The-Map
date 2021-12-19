//
//  MapViewController.swift
//  On The Map 1
//
//  Created by Manish raj(MR) on 16/12/21.
//

import Foundation
import UIKit
import MapKit

class MapPinViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        mapView.delegate = self
        Userlocation.shared.subscribe(Userlocation.MAP_VIEW_SUBSCRIBER_NAME, callback: self.onLocationsChange)
        if (Udata.shared.cachedStudentInformations.count > 0) {
            self.onLocationsChange()
        }
    }
    
    private func onLocationsChange() {
        DispatchQueue.main.async {
            let locations = Udata.shared.cachedStudentInformations
            
            var annotations = [MKPointAnnotation]()
            
            
            for location in locations! {
                
                let lat = CLLocationDegrees(location.latitude);
                let long = CLLocationDegrees(location.longitude);
                
                
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let first = location.firstName;
                let last = location.lastName;
                let mediaURL = location.mediaURL;
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(first) \(last)"
                annotation.subtitle = mediaURL
                
                annotations.append(annotation)
            }
            
            self.mapView.addAnnotations(annotations)
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let toOpen = view.annotation?.subtitle! {
                userlocationdata.openUrl(urlToOpen: toOpen)
            }
        }
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


