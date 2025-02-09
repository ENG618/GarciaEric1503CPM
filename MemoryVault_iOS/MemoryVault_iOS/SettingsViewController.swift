//
//  SettingsViewController.swift
//  MemoryVault_iOS
//
//  Created by Eric Garcia on 3/10/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBAction func closeBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func signOutBtn(sender: AnyObject) {
        PFUser.logOut()
        var currentUser = PFUser.currentUser()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Some code
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
}