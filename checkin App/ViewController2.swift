//
//  ViewController2.swift
//  checkin App
//
//  Created by Thinh Nguyen on 7/11/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//


// OWNER SIDE
import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController2: UIViewController {
    
    // Initalize the values
    var current_uid: String!
    var myCustomnerList: [Any] = []
    var myTodayList: [Any] = []
    var holidaysList: [Any] = []
    var ref: DatabaseReference?
    var handle: DatabaseHandle?

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
        
        // Loading the customer data from database
        ref = Database.database().reference()
        
        // Only fetch to get all customers
        ref?.child(self.current_uid).child("AllUser").observe(.childAdded, with: { (snapshot) in
            let value = snapshot.value
            // Append data to array
            self.myCustomnerList.append(value!)
        }) { (error) in
            print(error.localizedDescription)
        }
        
        // Only fetch to get all holidays
        ref?.child(self.current_uid).child("Holidays").observe(.childAdded, with: { (snapshot) in
            let value = snapshot.value
            // Append data to array
            self.holidaysList.append(value!)
        }) { (error) in
            print(error.localizedDescription)
        }
        
        // Only fetch to get all today customers
        ref?.child(self.current_uid).child("Today").observe(.childAdded, with: { (snapshot) in
            let value = snapshot.value
            // Append data to array
            self.myTodayList.append(value!)
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
