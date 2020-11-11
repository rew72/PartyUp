//
//  ForgotPasswordController.swift
//  PartyUp Registration
//
//  Created by Anim on 3/10/17.
//  Copyright © 2017 PartyUp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ForgotPasswordController: UIViewController {
    
    //variables
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var resetEmailTextField: UITextField!
    
    //when flip switch function
    @IBAction func flipSwitch(_ sender: Any) {
        
        if mySwitch.isOn //if the switch is flipped to on
        {
            resetButton.isHidden = false; //show reset button
            backButton.isHidden = true; //hide return button
        }
            
        else //if the flip is switched off
        {
            resetButton.isHidden = true; //hide reset button
            backButton.isHidden = false; //show back button
        }
        
    }
    
    //function when reset button is activated
    @IBAction func resetPassword(_ sender: Any) {
        
        if self.resetEmailTextField.text == "" { //if the email text field is blank
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else { //if the email text field isnt empty
            FIRAuth.auth()?.sendPasswordReset(withEmail: self.resetEmailTextField.text!, completion: { (error) in //call Firebase function to reset password
                
                var title = ""
                var message = ""
                
                if error != nil { //if email authentication returns an error
                    title = "Error!"
                    message = (error?.localizedDescription)!
                } else { //if the email authentication works, password is reset
                    title = "Success!"
                    message = "Password reset email sent."
                    self.resetEmailTextField.text = ""
                }
                
                //display a pop-up message telling the user if the reset failed or worked
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            })
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resetButton.isHidden = true; //the reset button is hidden upon loading this screen for the first time
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
