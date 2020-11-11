//
//  AccountInfo.swift
//  PartyUp Registration
//
//  Created by Anim on 5/8/17.
//  Copyright © 2017 PartyUp. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class AccountInfo : UIViewController{
    
    var emailText = String()
    
    var ref : FIRDatabaseReference!
    
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var Agreement: UISwitch!
    @IBOutlet weak var FinishRegistration: UIButton!
    @IBOutlet weak var ErrorLabel: UILabel!
    
    
    
    //Flipped the Switch
    @IBAction func AcceptTerms(_ sender: Any) {
        
        if Agreement.isOn
        {
            FinishRegistration.isHidden = false
        }
        else
        {
          FinishRegistration.isHidden = true
        }
        
    }
    
    
    // Finish Registration and Move to Sign In
    @IBAction func CompleteRegistration(_ sender: Any) {
        
        if(FirstName.text == "" || LastName.text == ""){
            ErrorLabel.isHidden = false
        }
        else{
            
            self.ref?.child("Users").child(movingEmail!).child("FirstName").setValue(FirstName.text!)
            
            self.ref?.child("Users").child(movingEmail!).child("LastName").setValue(LastName.text!)
            
        
            
        }
    }
    
    
 
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        ErrorLabel.isHidden = true
        FinishRegistration.isHidden = true
        ref = FIRDatabase.database().reference()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
