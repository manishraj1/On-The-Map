//
//  KeyboardAwareViewController.swift
//  On The Map 1
//
//  Created by Manish raj(MR) on 16/12/21.
//

import Foundation
import UIKit

class KeyViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        subscribeToKeyboardNotifications();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        unsubscribeFromKeyboardNotifications();
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil);
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
      
        if (self.isKeyBoardAwareComponentEditing() && view.frame.origin.y >= 0) {
            view.frame.origin.y -= getKeyboardHeight(notification);
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if (view.frame.origin.y < 0) {
            view.frame.origin.y = 0;
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo;
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue;
        return keyboardSize.cgRectValue.height;
    }
    
    func isKeyBoardAwareComponentEditing() -> Bool {
        fatalError("Need to override this method")
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

