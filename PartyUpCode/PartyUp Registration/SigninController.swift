//
//  SigninController.swift
//  PartyUp Registration
//
//  Created by Anim on 3/9/17.
//  Copyright © 2017 PartyUp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SigninController: UIViewController {
    //email text field
    @IBOutlet weak var signinEmail: UITextField!
    var emailText = String()
    //password text field
    @IBOutlet weak var signinPassword: UITextField!
    
    //button click
    @IBAction func signinAction(_ sender: Any) {
        movingEmail = signinEmail.text!
        let email = movingEmail! + "@drexel.edu"
        
        FIRAuth.auth()?.signIn(withEmail: email, password: self.signinPassword.text!) { (user, error) in
            
            if error == nil {
                
                //Print into the console if successfully logged in
                print("You have successfully logged in")
                
                //Go to the HomeViewController if the login is sucessful
                self.performSegue(withIdentifier: "SigninToHome", sender: nil)
                
            }
            else {
                
                //Tells the user that there is an error and then gets firebase to tell them the error
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signinEmail.text = emailText
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
