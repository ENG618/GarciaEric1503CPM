//
//  MemoryViewController.swift
//  MemoryVault_iOS
//
//  Created by Eric Garcia on 3/13/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController{
    
    var memorytoEdit : Memory?
    
    @IBOutlet var titleTF: UITextField!
    @IBOutlet var dateTF: UITextField!
    @IBOutlet var guestsTF: UITextField!
    @IBOutlet var notesTF: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentMemory = memorytoEdit {
            titleTF.text = currentMemory.memoryTitle
            
            let dateFormater = NSDateFormatter()
            dateFormater.dateFormat = "MM/dd/yy"
            dateTF.text = dateFormater.stringFromDate(currentMemory.memoryDate)
            
            guestsTF.text = String(currentMemory.memoryGuestCount)
            notesTF.text = currentMemory.memoryNotes
        }
        
        // Load current date into text field
        getCurrentDateAsString()
    }
    
    func getCurrentDateAsString(){
        let dateFormater = NSDateFormatter()
        dateFormater.dateFormat = "MM/dd/yy"
        let currentDate = NSDate()
        dateTF.text = dateFormater.stringFromDate(currentDate)
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        dateTF.text = dateFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func showDatePicker(sender: UITextField) {
        var datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func getDateFromString(dateString: String) -> NSDate {
        var formater = NSDateFormatter()
        formater.dateFormat = "MM/dd/yy"
        let date = formater.dateFromString(dateString)
        return date!
    }
    
    func validateMemory(memory: Memory) -> Bool {
        
        if (titleTF.text.isEmpty){
            showAlert("Please enter a title")
            return false
        }
        if (guestsTF.text.isEmpty) {
            showAlert("Please enter number of guests")
            return false
        }
        
        return true
    }
    
    func showAlert(alertMessage: String) {
        // Create Alert
        var validationAlert = UIAlertController(title: "Something isn't right...", message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        // Add Okay button
        validationAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        // Present alert
        self.presentViewController(validationAlert, animated: true, completion: nil)
    }
    
    @IBAction func SaveBtn(sender: UIBarButtonItem) {
        
        if let updatedMemory = memorytoEdit {
            updatedMemory.memoryTitle = titleTF.text
            updatedMemory.memoryDate = getDateFromString(dateTF.text)
            updatedMemory.memoryGuestCount = guestsTF.text.toInt()!
            updatedMemory.memoryNotes = notesTF.text
            
            updatedMemory.saveInBackground()
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            // Create new memory
            var newMemory: Memory = Memory()
            // Populate from user input
            newMemory.memoryTitle = titleTF.text
            newMemory.memoryDate = getDateFromString(dateTF.text)
            if (!guestsTF.text.isEmpty) {
                newMemory.memoryGuestCount = guestsTF.text.toInt()!
            }
            newMemory.memoryNotes = notesTF.text
            
            // Check validity
            if (validateMemory(newMemory)) {
                //Check network connection
                if (NetworkValidator.hasConnectivity()) {
                    // Save directly to parse
                    newMemory.saveInBackgroundWithBlock{
                        (success: Bool, error: NSError!) -> Void in
                        if (success) { // Saved successfully
                            self.dismissViewControllerAnimated(true, completion: nil)
                            newMemory.pinInBackground()
                            self.dismissViewControllerAnimated(true, completion: nil)
                        } else { // Something went wrong
                            println("Error: \(error) \(error.userInfo)")
                        }
                    }
                } else { // No network connection
                    // Save to localDataStore
                    newMemory.saveEventually({
                        (success: Bool, error: NSError!) -> Void in
                        if (success) { // Saved successfully
                            println("\(newMemory) synced online")
                        } else { // Something went wrong
                            println("Error: \(error) \(error.userInfo)")
                        }
                    })
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func cancelBtn(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
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