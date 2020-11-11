//
//  WebViewController.swift
//  PartyUp Registration
//
//  Created by Veenito Beenito on 6/7/17.
//  Copyright © 2017 PartyUp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class WebViewController: UIViewController {

    
    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    
    @IBOutlet weak var webview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ref = FIRDatabase.database().reference()
        
        FIRDatabase.database().reference().child("Parties").child(nameofParty!).observeSingleEvent(of: .value, with: {(snap) in
            if let snapDict = snap.value as? Dictionary <String, AnyObject>{
                let cost = snapDict["Cost"] as? String
                let paypal = snapDict["PayPal"] as? String
                let weurl = URL(string:paypal!+"/"+cost!)
                let urlrequest = URLRequest(url:weurl!)
                self.webview.loadRequest(urlrequest)
                
            }
        })
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
