//
//  ViewController2.swift
//  checkin App
//
//  Created by Thinh Nguyen on 7/11/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController2: UIViewController {

    // Logout button method logic
    @IBAction func logout_Button(_ sender: Any) {
        
        // Logout
        try! Auth.auth().signOut()
        // Go back to login page
        performSegue(withIdentifier: "logout_home", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Get the current user login data
        print(Auth.auth().currentUser?.email as Any)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
