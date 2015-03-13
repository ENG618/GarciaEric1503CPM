//
//  Memory.swift
//  MemoryVault_iOS
//
//  Created by Eric Garcia on 3/11/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import Foundation


class Memory: PFObject, PFSubclassing {
    
//    override class func initialize(){
//        var onceToken: dispatch_once_t = 0
//        dispatch_once(&onceToken) {
//            self.registerSubclass()
//        }
//    }
    
    // Constant for Class name
    class var MEMORIES: String {
        return "Memories"
    }
    
    // Constatns for row titles
    let TITLE = "Title"
    let DATE = "Date"
    let GUESTS = "Guests"
    let NOTES = "Notes"
    
    
    
    var memoryTitle: String {
        get {
            return objectForKey(TITLE) as String
        }
        set {
            setObject(memoryTitle, forKey: TITLE)
        }
    }
    var memoryDate: NSDate {
        get {
            return objectForKey(DATE) as NSDate
        }
        set {
            setObject(memoryDate, forKey: DATE)
        }
    }
    var memoryGuestCount: Int {
        get {
            return objectForKey(GUESTS) as Int
        }
        set {
            setObject(memoryGuestCount, forKey: GUESTS)
        }
    }
    var memoryNotes: String {
        get {
            return objectForKey(NOTES) as String
        }
        set {
            setObject(memoryNotes, forKey: NOTES)
        }
    }
    
    
    override class func load() {
        self.registerSubclass()
    }
    
    class func parseClassName() -> String! {
        return "Memories"
    }
}