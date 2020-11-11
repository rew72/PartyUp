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

var nameofParty: String?


class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    
    
    var partyData = [String]()
    
    @IBOutlet weak var partyList: UITableView!
    
    @IBOutlet weak var searchAds: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = GADRequest()
        
        request.testDevices = [kGADSimulatorID]
        
        searchAds.adUnitID = "ca-app-pub-4901825729518258/9503946329" // Displaying an ad unit on the page
        searchAds.rootViewController = self
        searchAds.load(request)
        
        // Do any additional setup after loading the view.
        
        partyList.delegate = self
        partyList.dataSource = self
        
        ref = FIRDatabase.database().reference()
        
        // Displaying new parties whenever they are added to the database
        databaseHandle = ref?.child("PartyList").observe(.childAdded, with: { (snapshot) in
            let party = snapshot.value as? String
            
            if  let actualParty = party {
                
                self.partyData.append(actualParty) // Constantly updating
                
                self.partyList.reloadData()
                
                
            }
            
           
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Creating the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyData.count
    }
    // Moving to the screen with the party information on it
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "B")
        self.navigationController?.pushViewController(viewController!, animated: true)
        nameofParty = partyData[indexPath.row]
    }
    // Naming the table cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "partyCell")
        cell?.textLabel?.text = partyData[indexPath.row]
        return cell!
    }
    
    @IBAction func Done(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil) // Leaving the screen
        
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
