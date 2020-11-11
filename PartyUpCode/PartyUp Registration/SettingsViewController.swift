//
//  SettingsViewController.swift
//  PartyUp Registration
//
//  Created by Anim on 3/15/17.
//  Copyright © 2017 PartyUp. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SettingsViewController: UIViewController {

    @IBAction func logout(_ sender: Any) {
        
        //self.performSegue(withIdentifier: "settingsToLogin", sender: nil)
        
    }
    
    @IBOutlet weak var settingsAd: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = GADRequest()
        
        request.testDevices = [kGADSimulatorID]
        
        settingsAd.adUnitID = "ca-app-pub-4901825729518258/2468690728" // Displaying Ads
        settingsAd.rootViewController = self
        settingsAd.load(request)

        // Do any additional setup after loading the view.
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
