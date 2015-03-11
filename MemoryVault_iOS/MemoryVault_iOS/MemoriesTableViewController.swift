//
//  MemoriesTableViewController.swift
//  MemoryVault_iOS
//
//  Created by Eric Garcia on 3/10/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import Foundation
import UIKit

class MemoriesTableViewController: PFQueryTableViewController {
    
    override init!(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.parseClassName = "Memories"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        
    }
    
    override func queryForTable() -> PFQuery! {
        var query = PFQuery(className: "Memories")
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("memoryCell") as MemoryTableViewCell!
        if cell == nil {
            //            cell = MemoryTableViewCell(st
            
        }
        return cell
    }
}
