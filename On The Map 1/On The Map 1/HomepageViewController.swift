//
//  SignInViewController.swift
//  On The Map 1
//
//  Created by Manish raj(MR) on 16/12/21.
//

import UIKit

class HomepageViewController: KeyViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginErrorTextDisplay: UILabel!

    private var currentEditingTextField : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLoginErrorText("");
        self.emailTextView.delegate = self
        self.passwordTextView.delegate = self
        
    }
    
    @IBAction func onLogin(_ sender: Any) {
        self.setLoginErrorText("");
        let username = emailTextView.text!
        let password = passwordTextView.text!
        self.renderSpinner()
        ClientU.shared.startSession(withUsername: username, withPassword: password, onSuccess: self.onLoginSuccess, onError: self.setLoginErrorText)
    }
    
    @IBAction func onClickSignUp(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://auth.udacity.com/sign-up")!, options: [:], completionHandler: nil)
    }
    
    private func setLoginErrorText(_ text: String) {
        DispatchQueue.main.async {
            self.dismissSpinner()
            self.loginErrorTextDisplay.text = text
        }
    }
    
    private func onLoginSuccess() {
        DispatchQueue.main.async {
            self.dismissSpinner()
            self.emailTextView.text = ""
            self.passwordTextView.text = ""
            self.performSegue(withIdentifier: "showTabBarViewController", sender: self);
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.currentEditingTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.currentEditingTextField = nil
    }
    
    override func isKeyBoardAwareComponentEditing() -> Bool {
        if (self.currentEditingTextField != nil) {
            return self.currentEditingTextField! == self.passwordTextView
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.currentEditingTextField = nil
        textField.resignFirstResponder()
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


