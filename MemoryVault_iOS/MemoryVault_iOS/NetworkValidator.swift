//
//  NetworkValidator.swift
//  MemoryVault_iOS
//
//  Created by Eric Garcia on 3/25/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import UIKit

class NetworkValidator {
    
    let NETWORK_VALIDATOR: String = "NetworkValidator"
    
    init() {
        // NSNotificationCenter.defaultCenter().addObserver(self, selector: networkChanged(), name: Reachability(), object: nil)
    }
    
    
    class func hasConnectivity() -> Bool {
        let reachability: Reachability = Reachability.reachabilityForInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().value
        return networkStatus != 0
    }
    
    func networkChanged() {
        println("\(NETWORK_VALIDATOR) network has changed")
    }
}
