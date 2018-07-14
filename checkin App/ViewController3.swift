//
//  ViewController3.swift
//  checkin App
//
//  Created by Thinh Nguyen on 7/12/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//


// CLIENT SIDE
import UIKit
import FirebaseAuth

class ViewController3: UIViewController {

    // Initalize the values
    var current_uid:String!
    
    // Logout button method logic
    @IBAction func logout_Button(_ sender: Any) {
        
        // Logout
        try! Auth.auth().signOut()
        // Go back to login page
        performSegue(withIdentifier: "home_View", sender: self)
        print("Logout")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the current user login data
        print(Auth.auth().currentUser?.email as Any)
        
        // Get the user UID
        self.current_uid = Auth.auth().currentUser?.uid
        print(self.current_uid as String)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
