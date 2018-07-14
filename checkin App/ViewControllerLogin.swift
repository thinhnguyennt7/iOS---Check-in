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

    // Initlize the values
    @IBOutlet weak var pass_Input: UITextField!
    @IBOutlet weak var email_Input: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var error_Log: UILabel!
    
    
    // Next button logic nethod AUTH
    @IBAction func login_Button(_ sender: Any) {
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
    
    // When page load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.error_Log.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
