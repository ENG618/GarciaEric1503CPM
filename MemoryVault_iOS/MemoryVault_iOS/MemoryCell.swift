//
//  MemoryViewCell.swift
//  MemoryVault_iOS
//
//  Created by Eric Garcia on 3/13/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import Foundation
import UIKit

class MemoryCell: UITableViewCell {
    
    @IBOutlet var memoryTitle: UILabel!
    @IBOutlet var memoryDate: UILabel!
    @IBOutlet var memoryGuests: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}