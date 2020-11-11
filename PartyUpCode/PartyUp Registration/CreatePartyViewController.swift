//
//  CreatePartyViewController.swift
//  PartyUpHost
//
//  Created by Robert Wilson on 2/28/17.
//  Copyright © 2017 PartyUp. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

var currentParty : String?

class CreatePartyViewController: UIViewController {
    // Textfield
    @IBOutlet weak var PartyName: UITextField!
    @IBOutlet weak var Address: UITextField!
    @IBOutlet weak var Date: UITextField!
    @IBOutlet weak var Time: UITextField!
    @IBOutlet weak var Cost: UITextField!
    @IBOutlet weak var Description: UITextField!
    @IBOutlet weak var paypal: UITextField!
    
    
    var ref:FIRDatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function sends party info to the database on click of button
    @IBAction func Submit(_ sender: UIButton) {
        ref?.child("PartyList").observeSingleEvent(of: .value, with: { (snapshot) in
            let doesExist = self.PartyName.text
            if snapshot.hasChild(doesExist!){
                
                // If the party name is taken, the user will not change the value in the database
                let alert = UIAlertController(title: "Alert", message: "There is already a party with that name", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                
            }
            else{
                // If the party name doesn't exist, all the information is written to the database
                if self.PartyName.text != ""{
                    self.ref?.child("PartyList").child(self.PartyName.text!).setValue(self.PartyName.text)
                    self.ref?.child("Users").child(movingEmail!).child("HostedParties").child(self.PartyName.text!).setValue(self.PartyName.text)
                    self.ref?.child("Parties").child(self.PartyName.text!).child("Name").setValue(self.PartyName.text)
                    self.ref?.child("Parties").child(self.PartyName.text!).child("Address").setValue(self.Address.text)
                    self.ref?.child("Parties").child(self.PartyName.text!).child("Date").setValue(self.Date.text)
                    self.ref?.child("Parties").child(self.PartyName.text!).child("Time").setValue(self.Time.text)
                    self.ref?.child("Parties").child(self.PartyName.text!).child("Cost").setValue(self.Cost.text)
                    self.ref?.child("Parties").child(self.PartyName.text!).child("Description").setValue(self.Description.text)
                    self.ref?.child("Parties").child(self.PartyName.text!).child("Host").setValue(movingEmail)
                    self.ref?.child("Parties").child(self.PartyName.text!).child("PayPal").setValue("https://www."+self.paypal.text!)
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
            
            
        })
        
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
