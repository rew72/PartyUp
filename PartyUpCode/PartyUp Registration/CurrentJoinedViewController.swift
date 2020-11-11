//
//  CurrentJoinedViewController.swift
//  PartyUp Registration
//
//  Created by Veenito Beenito on 6/7/17.
//  Copyright © 2017 PartyUp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Cosmos

class CurrentJoinedViewController: UIViewController {

    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    
    @IBOutlet weak var rate: UITextField!
    @IBOutlet weak var host: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var rating: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = FIRDatabase.database().reference()
        FIRDatabase.database().reference().child("Parties").child(party!).observeSingleEvent(of: .value, with: {(snap) in
            if let snapDict = snap.value as? Dictionary <String, AnyObject>{
                self.cost.text = "$" + (snapDict["Cost"] as! String)
                self.name.text = snapDict["Name"] as? String
                self.time.text = snapDict["Time"] as? String
                self.address.text = snapDict["Address"] as? String
                self.date.text = snapDict["Date"] as? String
                self.des.text = snapDict["Description"] as? String
                self.host.text = snapDict["Host"] as? String
                let hoster = snapDict["Host"] as? String
                FIRDatabase.database().reference().child("Users").child(hoster!).observeSingleEvent(of: .value, with: {(snap) in
                    if let snapDicts = snap.value as? Dictionary <String, AnyObject>{
                        var name = String()
                        name+=(snapDicts["FirstName"] as? String)!
                        name+=" "
                        name+=(snapDicts["LastName"] as? String)!
                        self.host.text = (name)
                    }
                })


                //listens for changes and dynamically changes rating for each user
                self.ref?.child("Users").child(hoster!).child("Rating").observe(.value, with: { (snapshot) in
                    var total = 0.00
                    let enumerator = snapshot.children
                    let numberofChildren = snapshot.childrenCount
                    total = 0.00
                    //iterates over each rater and adds to total
                    while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                        total = total + (rest.value as! Double)
                    }
                    //divides total by numberofChildren to get average rating
                    self.rating.rating = total / Double(numberofChildren)
                })
                
                
                
            }
        })
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submit(_ sender: Any) {
        FIRDatabase.database().reference().child("Parties").child(party!).observeSingleEvent(of: .value, with: {(snap) in
            if let snapDict = snap.value as? Dictionary <String, AnyObject>{
                let hostname = snapDict["Host"] as? String
                self.ref = FIRDatabase.database().reference()
                let doublerate = Double(self.rate.text!)
                self.ref?.child("Users").child(hostname!).child("Rating").child(movingEmail!).setValue(doublerate)
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
