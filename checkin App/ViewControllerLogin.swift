//
//  ViewControllerLogin.swift
//  checkin App
//
//  Created by Thinh Nguyen on 7/13/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewControllerLogin: UIViewController {

    // INITLIZE THE VALUES
    @IBOutlet weak var pass_Input: UITextField!
    @IBOutlet weak var email_Input: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var error_Log: UILabel!
    
    
    // NEXT BUTTON LOGIC NETHOD AUTH
    @IBAction func login_Button(_ sender: Any) {
        view.endEditing(true)
        self.error_Log.text = ""
        if email_Input.text != "" && pass_Input.text != "" {
            Auth.auth().signIn(withEmail: email_Input.text!, password: pass_Input.text!, completion: {(user, error) in
                
                // If the email and password correct
                if user != nil {
                    print("Sign in successfully")
                    
                    if self.segmentControl.selectedSegmentIndex == 0 {
                        print("In Owner Side")
                        self.performSegue(withIdentifier: "owner_View", sender: self)
                    } else {
                        print("In Client Side")
                        self.performSegue(withIdentifier: "client_View", sender: self)
                    }
                
                // If not correct
                } else {
                    if let myError = error?.localizedDescription {
                        print(myError)
                        self.error_Log.text = "Error: " + myError
                    } else {
                        print("ERROR")
                        self.error_Log.text = "ERROR. Can not log in"
                    }
                }
            })
        } else {
            print("Email or Password can not be empty")
            self.error_Log.text = "Error: Email or Password can not be empty"
        }
    }
    
    // WHEN PAGE LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.error_Log.text = ""
        configureTextFields()
        configureTapGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // TEXTFIELD CONFIGUTE DELEGATE
    private func configureTextFields() {
        email_Input.delegate = self
        pass_Input.delegate = self
    }
    
    // TAPGESTURE CONFIGURE
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewControllerLogin.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    // WHEN WE TAP OUTSIDE THE KEYBOARD
    @objc func handleTap() {
        print("Handle tap was called")
        view.endEditing(true)
    }
    
    // AUTO SHIFT TO FIT THE KEYBOARD AND TEXTFIELD
    func moveTextFiled(textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance) // if statement
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
}

// ABOUT THE TEXT FIELD
extension ViewControllerLogin: UITextFieldDelegate {
    
    // KEYBOARD SHOWS
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextFiled(textField: textField, moveDistance: -250, up: true)
    }
    
    // KEYBOARD HIDDEN
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextFiled(textField: textField, moveDistance: -250, up: false)
    }
    
    // WHEN WE CLICK RETURN ON THE KEYBOARD, DIMISS THE KEYBOARD
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
