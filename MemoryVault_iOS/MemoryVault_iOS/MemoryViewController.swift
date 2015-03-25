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
    
    @IBAction func SaveBtn(sender: UIBarButtonItem) {
        var newMemory: Memory = Memory()
        newMemory.memoryTitle = titleTF.text
        newMemory.memoryDate = getDateFromString(dateTF.text)
        newMemory.memoryGuestCount = guestsTF.text.toInt()!
        newMemory.memoryNotes = notesTF.text
        newMemory.saveEventually({
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                // Something went wrong
            }
        })
        
//        newMemory.saveInBackgroundWithBlock{
//            (success: Bool, error: NSError!) -> Void in
//            if (success) {
//                self.dismissViewControllerAnimated(true, completion: nil)
//            } else {
//                // Something went wrong
//            }
//        }
        
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