//
//  NewViewController.swift
//  joinparty
//
//  Created by Veenito Beenito on 3/11/17.
//  Copyright © 2017 team01. All rights reserved.
//

import UIKit
import Cosmos
import Firebase
import FirebaseDatabase

class CurrentPartylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var label: UILabel!
    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    
    var attendees = [String]()

    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var hostname: UILabel!
    @IBOutlet weak var leavebutton: UIBarButtonItem!
    @IBOutlet weak var joinbutton: UIBarButtonItem!
    @IBOutlet weak var AttendeesList: UITableView!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var adress: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        AttendeesList.delegate = self
        AttendeesList.dataSource = self
        
        ref = FIRDatabase.database().reference()
        // Do any additional setup after loading the view.
        
        // Reading the values from the database and changing the text on the screen
        FIRDatabase.database().reference().child("Parties").child(nameofParty!).observeSingleEvent(of: .value, with: {(snap) in
            if let snapDict = snap.value as? Dictionary <String, AnyObject>{
                self.cost.text = "$" + (snapDict["Cost"] as! String)
                self.label.text = snapDict["Name"] as? String
                self.time.text = snapDict["Time"] as? String
                self.adress.text = snapDict["Address"] as? String
                self.date.text = snapDict["Date"] as? String
                self.des.text = snapDict["Description"] as? String
                let hoster = snapDict["Host"] as? String
                FIRDatabase.database().reference().child("Users").child(hoster!).observeSingleEvent(of: .value, with: {(snap) in
                    if let snapDicts = snap.value as? Dictionary <String, AnyObject>{
                        var name = String()
                        name+=(snapDicts["FirstName"] as? String)!
                        name+=" "
                        name+=(snapDicts["LastName"] as? String)!
                        self.hostname.text = (name)
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
        
        // Display the people attending the party
        databaseHandle = ref?.child("Parties").child(nameofParty!).child("Attendees").observe(.childAdded, with:{ (snapshot) in
            if let person = snapshot.value as? String{
                self.attendees.append(person)
                print(person)
                self.AttendeesList.reloadData()
            }
        })

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Leave(_ sender: Any) {
            FIRDatabase.database().reference().child("Parties").child(nameofParty!).child("Attendees").observeSingleEvent(of: .value, with: {(snap) in
            if let snapDict = snap.value as? Dictionary<String, AnyObject>{
                if let person = snapDict[movingEmail!] as? String{
                if let index = self.attendees.index(of: person){
                    self.attendees.remove(at: index)
                    let indexPath = IndexPath(row:index, section:0)
                    self.AttendeesList.deleteRows(at: [indexPath], with: .automatic)
                    }
                }
            }
        })
        let firebase = FIRDatabase.database().reference()
        firebase.child("Parties").child(nameofParty!).child("Attendees").child(movingEmail!).removeValue()
        firebase.child("Users").child(movingEmail!).child("JoinedParties").child(nameofParty!).removeValue()
    }
    @IBAction func Join(_ sender: Any) {
        if(self.cost.text=="$0") || self.cost.text=="$0.00"{
            ref = FIRDatabase.database().reference()
            FIRDatabase.database().reference().child("Users").child(movingEmail!).observeSingleEvent(of: .value, with: {(snap) in
                if let snapDict = snap.value as? Dictionary <String, AnyObject>{
                    let first = snapDict["FirstName"] as? String
                    let last = snapDict["LastName"] as? String
                    
                    self.ref?.child("Parties").child(nameofParty!).child("Attendees").child(movingEmail!).setValue(first! + " " + last!)
                }
            })
            ref?.child("Users").child(movingEmail!).child("JoinedParties").child(nameofParty!).setValue(nameofParty!)
        }
        else{
            let viewController = storyboard?.instantiateViewController(withIdentifier: "Web")
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
    }
    // Writing to the database with the name of the attendee when the button is clicked
    
    // Table for the attendees
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendees.count
    }
    
    // Updating table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "attend")
        cell?.textLabel?.text = attendees[indexPath.row]
        return cell!
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
