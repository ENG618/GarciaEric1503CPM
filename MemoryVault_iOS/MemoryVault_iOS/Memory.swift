//
//  Memory.swift
//  MemoryVault_iOS
//
//  Created by Eric Garcia on 3/11/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import Foundation


class Memory: PFObject, PFSubclassing {
    
    let TAG = "Local memories"
    
    // Constants for row titles
    let TITLE: String = "Title"
    let DATE: String = "Date"
    let GUESTS: String = "Guests"
    let NOTES: String = "Notes"
    
    
    
    var memoryTitle: String {
        get {
            return objectForKey(TITLE) as String
        }
        set {
            setObject(newValue, forKey: TITLE)
        }
    }
    var memoryDate: NSDate {
        get {
            return objectForKey(DATE) as NSDate
        }
        set {
            setObject(newValue, forKey: DATE)
        }
    }
    var memoryGuestCount: Int {
        get {
            return objectForKey(GUESTS) as Int
        }
        set {
            setObject(newValue, forKey: GUESTS)
        }
    }
    var memoryNotes: String {
        get {
            return objectForKey(NOTES) as String
        }
        set {
            setObject(newValue, forKey: NOTES)
        }
    }
    
    class func memoryQuery() -> PFQuery {
        let query: PFQuery = PFQuery(className: Memory.parseClassName())
        query.orderByDescending("Date")
        return query
    }
    
    class func memoryQueryFromLocal() -> PFQuery {
        let query: PFQuery = PFQuery(className: Memory.parseClassName())
        query.fromLocalDatastore()
        query.orderByDescending("Date")
        return query
    }
    
    override class func load() {
        self.registerSubclass()
    }
    
    class func parseClassName() -> String! {
        return "Memories"
    }
}