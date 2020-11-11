//
//  MainHostViewController.swift
//  PartyUpHost
//
//  Created by Robert Wilson on 2/28/17.
//  Copyright © 2017 PartyUp. All rights reserved.
//

import UIKit
import FirebaseDatabase


class PartyInfoViewController: UIViewController{
    
    var ref:FIRDatabaseReference?
    
    
    
    
    
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Address: UITextField!
    @IBOutlet weak var Date: UITextField!
    @IBOutlet weak var Time: UITextField!
    @IBOutlet weak var Cost: UITextField!
    @IBOutlet weak var Description: UITextField!
   
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        ref = FIRDatabase.database().reference()
        
        // Reading data from the database and settings values of the text
        FIRDatabase.database().reference().child("Parties").child(name!).observeSingleEvent(of: .value, with: {(snap) in
            
            if let snapDict = snap.value as? Dictionary <String, AnyObject>{
                
                self.Name.text = snapDict["Name"] as? String
                self.Address.text = snapDict["Address"] as? String
                self.Date.text = snapDict["Date"] as? String
                self.Time.text = snapDict["Time"] as? String
                self.Cost.text = snapDict["Cost"] as? String
                self.Description.text = snapDict["Description"] as? String
                
                
                
                
            }
        })
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Writting to the database, with the values of the text, when the submit button is clicked
    @IBAction func Submit(_ sender: UIButton) {
        if Name.text != ""{
            ref?.child("PartyList").child(Name.text!).setValue(Name.text)
            ref?.child("Parties").child(Name.text!).child("Name").setValue(Name.text)
            ref?.child("Parties").child(Name.text!).child("Address").setValue(Address.text)
            ref?.child("Parties").child(Name.text!).child("Date").setValue(Date.text)
            ref?.child("Parties").child(Name.text!).child("Time").setValue(Time.text)
            ref?.child("Parties").child(Name.text!).child("Cost").setValue(Cost.text)
            ref?.child("Parties").child(Name.text!).child("Description").setValue(Description.text)
            _ = navigationController?.popViewController(animated: true)

    }
}

    @IBAction func Delete(_ sender: Any) {
        let firebase = FIRDatabase.database().reference()
        firebase.child("Parties").child(name!).removeValue()
        firebase.child("Users").child(movingEmail!).child("HostedParties").removeValue()
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
