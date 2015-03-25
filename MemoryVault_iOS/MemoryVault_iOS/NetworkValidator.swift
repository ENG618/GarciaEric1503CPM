//
//  NetworkValidator.swift
//  MemoryVault_iOS
//
//  Created by Eric Garcia on 3/25/15.
//  Copyright (c) 2015 Garcia Enterprise. All rights reserved.
//

import UIKit

class NetworkValidator {
    
    class func hasConnectivity() -> Bool {
        let reachability: Reachability = Reachability.reachabilityForInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().value
        return networkStatus != 0
    }
}
