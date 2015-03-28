//
//  MemoryViewController.swift
//  MemoryVault_iOS
//
//  Created by Eric Garcia on 3/13/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController{
    
    @IBOutlet var titleTF: UITextField!
    @IBOutlet var dateTF: UITextField!
    @IBOutlet var guestsTF: UITextField!
    @IBOutlet var notesTF: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func validateMemory() -> Memory {
        
        // TODO: Validate memory
        var validatedMemory: Memory = Memory()
        
        if (titleTF.text.isEmpty){
            showAlert("Please enter a title")
        } else {
            validatedMemory.memoryTitle = titleTF.text
        }
        validatedMemory.memoryDate = getDateFromString(dateTF.text)
        if (guestsTF.text.isEmpty) {
            showAlert("Please enter number of guests")
        }
        validatedMemory.memoryGuestCount = guestsTF.text.toInt()!
        validatedMemory.memoryNotes = notesTF.text
        
        return validatedMemory
    }
    
    func showAlert(alertMessage: String) {
        // Create Alert
        var connectionAlert = UIAlertController(title: "Something isn't right...", message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        // Add Okay button
        connectionAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
    }
    
    @IBAction func SaveBtn(sender: UIBarButtonItem) {
        
        // TODO: Validate memory
        var newMemory: Memory = validateMemory()
        
        if (NetworkValidator.hasConnectivity()) {
            
            newMemory.saveInBackgroundWithBlock{
                (success: Bool, error: NSError!) -> Void in
                if (success) { // Saved successfully
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else { // Something went wrong
                    println("Error: \(error) \(error.userInfo)")
                }
            }
        } else { // No network connection
            newMemory.saveEventually({
                (success: Bool, error: NSError!) -> Void in
                if (success) { // Saved successfully
                    println("\(newMemory) synced online")
                } else { // Something went wrong
                    println("Error: \(error) \(error.userInfo)")
                }
            })
        }
        self.dismissViewControllerAnimated(true, completion: nil)
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