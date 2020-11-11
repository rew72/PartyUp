//
//  FeedbackViewController.swift
//  PartyUp Registration
//
//  Created by Veenito Beenito on 6/7/17.
//  Copyright © 2017 PartyUp. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FeedbackViewController: UIViewController {

    var ref:FIRDatabaseReference?
    @IBOutlet weak var text: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Send(_ sender: Any) {
        ref = FIRDatabase.database().reference()
        self.ref?.child("Feedback").childByAutoId().setValue(text.text)
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
