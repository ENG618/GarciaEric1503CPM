//
//  MemoriesViewController.swift
//  MemoryVault_iOS
//
//  Created by Eric Garcia on 3/9/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import Foundation
import UIKit

class MemoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellIdentifier = "mem_cell"
    var memories = [Memory]()
    
    @IBOutlet var memoriesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register custom cell
        var nib = UINib(nibName: "MemoryViewCell", bundle: nil)
        memoriesTableView.registerNib(nib, forCellReuseIdentifier: "memoryCell")
        
        
        
        updateMemories()
        
    }
    
    func updateMemories() {
        var query = PFQuery(className: Memory.MEMORIES)
        query.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for memory in objects {
                    var currentMemory: Memory = memory as Memory
                    NSLog("%@", currentMemory.memoryTitle)
                    self.memories.append(currentMemory)
                }
                self.memoriesTableView.reloadData()
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
            
        }
    }
    
    //
    // UITableView Data Source Methotds
    //
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("memoryCell", forIndexPath: indexPath) as MemoryViewCell
        
        if (memories.count > 0) {
            var currentMemory: Memory = memories[indexPath.row]
            
            cell.memoryTitle.text = currentMemory.memoryTitle
            
            var formater:NSDateFormatter = NSDateFormatter()
            formater.dateFormat = "MM/dd/yyyy"
            
            
            cell.memoryDate.text = formater.stringFromDate(currentMemory.memoryDate)
//            cell.memoryGuests.text = currentMemory.memoryGuestCount
        }
        
        
        return cell
    }
    
    //
    // UITableView Delegat Methods
    //
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        // indexpath is selected row
    }
}
