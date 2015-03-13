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
        var cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        return cell
    }
    
    // UITableView Delegat Methods
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        // indexpath is selected row
    }
}
