//
//  MainHostViewController.swift
//  PartyUpHost
//
//  Created by Robert Wilson on 2/28/17.
//  Copyright © 2017 PartyUp. All rights reserved.
//

import UIKit
import FirebaseDatabase
import GoogleMobileAds

var name: String?


class HostedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    
    
    var partyData = [String]()
    
    @IBOutlet weak var partyList: UITableView!
    
    @IBOutlet weak var BannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = GADRequest()
        
        request.testDevices = [kGADSimulatorID]
        
        BannerView.adUnitID = "ca-app-pub-4901825729518258/2468690728" // Displaying Ad unit
        BannerView.rootViewController = self
        BannerView.load(request)
        
        // Do any additional setup after loading the view.
        
        partyList.delegate = self
        partyList.dataSource = self
        
        ref = FIRDatabase.database().reference()
        
        
        // Observing the database
        databaseHandle = ref?.child("Users").child(movingEmail!).child("HostedParties").observe(.childAdded, with: { (snapshot) in
            let party = snapshot.value as? String
            
            if  let actualParty = party {
                
                self.partyData.append(actualParty)
                
                self.partyList.reloadData()
                
                
            }
            
            
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Table for each party created
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyData.count
    }
    // Updating the table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "A")
        self.navigationController?.pushViewController(viewController!, animated: true)
        name = partyData[indexPath.row]
    }
    // Naming each cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "partyCell")
        cell?.textLabel?.text = partyData[indexPath.row]
        return cell!
    }
    // Moving to another screen
    @IBAction func Done(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        
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
