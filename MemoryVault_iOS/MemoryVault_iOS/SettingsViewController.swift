//
//  SettingsViewController.swift
//  MemoryVault_iOS
//
//  Created by Eric Garcia on 3/10/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    @IBAction func closeBtn(sender: AnyObject) {
    }
    @IBAction func signOutBtn(sender: AnyObject) {
        PFUser.logOut()
        var currentUser = PFUser.currentUser()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Some code
    }
}