//
//  MemoriesViewController.swift
//  MemoryVault_iOS
//
//  Created by Eric Garcia on 3/9/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import UIKit

class MemoriesViewController: UIViewController {
    
    let cellIdentifier = "mem_cell"
    var memories = [Memory]()
    
    var reachability: Reachability?
    
    @IBOutlet var memoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // auto refresh ever 5 min
        let updateTimer = NSTimer.scheduledTimerWithTimeInterval(300.0, target: self, selector: "updateMemories", userInfo: nil, repeats: true)
        
        // Register custom cell
        var nib = UINib(nibName: "MemoryCell", bundle: nil)
        memoriesTableView.registerNib(nib, forCellReuseIdentifier: "memoryCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        updateMemories()
    }
    
    func updateMemories() {
        if (NetworkValidator.hasConnectivity()){ // Has internet connectivity
            println("Has connectivity")
            Memory.memoryQuery().findObjectsInBackgroundWithBlock{
                (objects: [AnyObject]!, error: NSError!) -> Void in
                if error == nil {
                    // The find succeeded.
                    // println("Successfully retrieved \(objects.count) memories.")
                    
                    Memory.unpinAllInBackground(self.memories, block: {
                        (success: Bool, error: NSError!) -> Void in
                        // Clear current list
                        self.memories = [Memory]()
                        // Do something with the found objects
                        for memory in objects {
                            let currentMemory: Memory = memory as Memory
                            // Save to localDataStore
                            currentMemory.pinInBackground()
                            println("\(currentMemory.memoryTitle) from Parse")
                            // Append to current
                            self.memories.append(currentMemory)
                        }
                    })
                    // Notify tableView to reload data
                    self.memoriesTableView.reloadData()
                } else {
                    // Log details of the failure
                    println("Error: \(error) \(error.userInfo)")
                }
                
            }
        } else { // No internet connectivity
            println("No connection")
            
            // Create Alert
            var connectionAlert = UIAlertController(title: "No Available Network!!", message: "Memories will be synced with cached data", preferredStyle: UIAlertControllerStyle.Alert)
            // Add Okay button
            connectionAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: { action in
                
                println("Okay from alert")
                // Load local query
                Memory.memoryQueryFromLocal().findObjectsInBackgroundWithBlock{
                    (objects: [AnyObject]!, error: NSError!) -> Void in
                    if error == nil { // No error present
                        // clear current list
                        self.memories = [Memory]()
                        // Add returned objects to array
                        for memory in objects {
                            let currentMemory: Memory = memory as Memory
                            println("\(currentMemory.memoryTitle) from localDataStore")
                            self.memories.append(currentMemory)
                        }
                        // Notify tableView to reload data
                        self.memoriesTableView.reloadData()
                    } else {
                        // Log details of the failure
                        println("Error: \(error) \(error.userInfo)")
                    }
                }
            }))
            // Present alert
            self.presentViewController(connectionAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func refreshBtn(sender: AnyObject) {
        // Refresh data
        updateMemories()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailsSegue" {
            // Get the new view controller using segue.destinationViewController.
            var memoryVC = segue.destinationViewController as MemoryViewController
            // Pass the selected object to the new view controller.
            if let indexPath = self.memoriesTableView.indexPathForSelectedRow() {
                let selectedMemory = memories[indexPath.row]
                memoryVC.memoryToEdit = selectedMemory
            }
        }
    }
}

// MARK: UITableView Data Source Methods
extension MemoriesViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Custom cell
        var cell = tableView.dequeueReusableCellWithIdentifier("memoryCell", forIndexPath: indexPath) as MemoryCell
        
        // Standard cell
        // var cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        if (memories.count > 0) {
            var currentMemory: Memory = memories[indexPath.row]
            
            // Date formater
            var formater:NSDateFormatter = NSDateFormatter()
            formater.dateFormat = "MM/dd/yy"
            
            // Custom cell
            cell.memoryTitle.text = currentMemory.memoryTitle
            
            cell.memoryDate.text = formater.stringFromDate(currentMemory.memoryDate)
            cell.memoryGuests.text = String(currentMemory.memoryGuestCount)

            /*
            // Standard cell
            cell.textLabel?.text = currentMemory.memoryTitle
            cell.detailTextLabel?.text = formater.stringFromDate(currentMemory.memoryDate)
            */
        }
        
        
        return cell
    }
}

// MARK: UITableView Delegate
extension MemoriesViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        // indexpath is selected row
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            var memoryToDelete = self.memories[indexPath.row]
            memoryToDelete.deleteEventually();
            updateMemories()
        }
    }
}
