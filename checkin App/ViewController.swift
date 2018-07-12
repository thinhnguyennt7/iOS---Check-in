//
//  ViewController.swift
//  checkin App
//
//  Created by Thinh Nguyen on 7/11/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    // Login Page user input
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    // Login Button login methoh AUTH
    @IBAction func loginAuth(_ sender: Any) {
        
        // In condition if the email and password not empty
        if emailInput.text != "" && passwordInput.text != "" {
            Auth.auth().signIn(withEmail: emailInput.text!, password: passwordInput.text!, completion: {(user, error) in
                
                // If the email and password correct
                if user != nil {
                    print("Sign in successfully")
                    
                    if self.segmentControl.selectedSegmentIndex == 0 {
                        print("In Owner side")
                        self.performSegue(withIdentifier: "owner_View", sender: self)
                    } else {
                        print("In Client side")
                        self.performSegue(withIdentifier: "client_view", sender: self)
                    }
                    
                // if not correct
                } else {
                    if let myError = error?.localizedDescription {
                        print(myError)
                    } else {
                        print("ERROR")
                    }
                }
            })
        } else {
            print("Email or Password can not be empty")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

