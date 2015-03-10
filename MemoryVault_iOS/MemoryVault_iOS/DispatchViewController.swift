//
//  DispatchViewController.swift
//  MemoryVault_iOS
//
//  Created by Eric Garcia on 3/9/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import Foundation
import UIKit

class DispatchViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        if isSignedIn() {
            loadMemoriesView()
        } else {
            showSignIn()
        }
    }
    
    func isSignedIn () -> Bool {
        var currentUser = PFUser.currentUser()
        
        if currentUser != nil {
            return true // Call segue to MemoriesTVC
        } else {
            return false // Show login
        }
    }
    
    func loadMemoriesView() {
        // Call segue for main view
        self.performSegueWithIdentifier("memoriesSegue", sender: nil)
    }
    
    func showSignIn() {
        var logInController = PFLogInViewController()
        
        logInController.fields = (PFLogInFields.UsernameAndPassword
            | PFLogInFields.LogInButton
            | PFLogInFields.SignUpButton
            | PFLogInFields.PasswordForgotten
            // | PFLogInFields.Facebook
            // | PFLogInFields.Twitter
        )
        
        logInController.delegate = self
        self.presentViewController(logInController, animated:true, completion: nil)
    }
    
    // PFLogInViewController Delegat methods
    
    func logInViewController(logInController: PFLogInViewController!, didFailToLogInWithError error: NSError!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController!, didLogInUser user: PFUser!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        loadMemoriesView()
    }
    
    func logInViewController(logInController: PFLogInViewController!, shouldBeginLogInWithUsername username: String!, password: String!) -> Bool {
        return true
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
