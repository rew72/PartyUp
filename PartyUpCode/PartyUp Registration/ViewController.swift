//
//  ViewController.swift
//  PartyUp Registration
//
//  Created by Robert Wilson on 3/3/17.
//  Copyright © 2017 PartyUp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

var movingEmail : String?

class ViewController: UIViewController {
    
    //Textfields for email and password
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //label for displaying message
    @IBOutlet weak var labelMessage: UILabel!
    
    //button for registration
    
    @IBAction func Register(_ sender: UIButton){
        
        //do the registration operation here
        
        //first take the email and password from the views
        movingEmail = emailTextField.text
        let email = emailTextField.text! + "@drexel.edu"  //Creating a GLOBAL variable for usernames
        let password = passwordTextField.text
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password!, completion: { (user: FIRUser?, error) in
            if error == nil { //if the database does not return an error (successful authentication)
                
                //Print into the console if successfully registered
                print("You have successfully signed up")
                
                self.labelMessage.text = "You are successfully registered!" //Changes label text
                self.performSegue(withIdentifier: "RegisterToAccountInfo", sender: nil) //Automatically segues to sign in
            }
            else{ //authentication returns an error (registration failed)
                self.labelMessage.text = "Registration Failed... Please Try Again" //Changes label text
                //Pop-up alert displaying an error message from Firebase
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
    
    // Allows the user to type in an email on the register screen and have it transfer to the sign in screen when activating a segue. ~ Abir Razzak
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


