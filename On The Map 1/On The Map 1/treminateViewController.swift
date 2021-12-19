//
//  TabBarViewController.swift
//  On The Map 1
//
//  Created by Manish raj(MR) on 16/12/21.
//

import Foundation
import UIKit

class treminateViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        ClientP.shared.getStudentLocation(onSuccess: self.fetchSuccess, onError: self.onError)
    }
    
    @IBAction func addPin(_ sender: Any) {
        var isDuplicate = false
        for item in Udata.shared.cachedStudentInformations {
            if (item.uniqueKey == Udata.shared.userUniqueKey) {
                isDuplicate = true
            }
        }
        if (isDuplicate) {
            let alert = UIAlertController(title: "You have Already Posted a Student Location. Would You Like to Overwrite You Current Location?", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Overwrite", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                self.performSegue(withIdentifier: "AddPinDetailPage", sender: nil);
            }))
            
            self.present(alert, animated: true)
        } else {
            performSegue(withIdentifier: "AddPinDetailPage", sender: nil);
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        ClientP.shared.getStudentLocation(onSuccess: self.fetchSuccess, onError: self.onError)
    }
    
    @IBAction func logOut(_ sender: Any) {
        ClientU.shared.deleteSession(
            onSuccess: self.logOutSuccess,
            onError: self.onError)
    }
    
    private func fetchSuccess(_ locations: Array<Userlocationsystem>) {
        Udata.shared.cachedStudentInformations = locations;
        // notify current selected view controller
        Userlocation.shared.notify()
    }
    
    private func onError(_ error: String) {
        let alert = UIAlertController(title: "Something went wrong, please try again", message: error, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    private func logOutSuccess() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "backToSignIn", sender: self)
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
