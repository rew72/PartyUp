//
//  HistoryViewController.swift
//  PartyUp Registration
//
//  Created by Veenito Beenito on 6/7/17.
//  Copyright © 2017 PartyUp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

var party: String?

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var historypage: UITableView!
    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    
    var partyData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        historypage.delegate = self
        historypage.dataSource = self
        // Do any additional setup after loading the view.
        ref = FIRDatabase.database().reference()
        
        databaseHandle = ref?.child("Users").child(movingEmail!).child("JoinedParties").observe(.childAdded, with: { (snapshot) in
            let party = snapshot.value as? String
            if  let actualParty = party {
                self.partyData.append(actualParty) // Constantly updating
                self.historypage.reloadData()
            }
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyData.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "joined")
        self.navigationController?.pushViewController(viewController!, animated: true)
        party = partyData[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "history")
        cell?.textLabel?.text = partyData[indexPath.row]
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
