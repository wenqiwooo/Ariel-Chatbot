//
//  ConnectivityModule.swift
//  NPLModule
//
//  Created by Wu Wenqi on 10/6/15.
//  Copyright © 2015 SIA App Challenge. All rights reserved.
//

import Foundation

public class ConnectivityModule {

    init() {
    }
    
    func request(x: Int) -> String {
        
        // Output declaration for Connectivity
        // [0]: Usage
        // [1]: Price
        // [2]: Purchase
        
        var reply = ""
        switch x {
        case 0:
            reply += "Here are some tips on WiFi usage.\nTo use the WiFi, just request me for a session.\nDo note that WiFi sessions are chargeable and a MasterCard account is required."
            break
        case 1:
            reply += "The pricing of SITAONAIR WiFi is as follows.\n10USD for 100MB data"
            break
        case 2:
            reply += "Would you like to purchase one WiFi session?\n10USD for 100MB data"
            user.setAffirmationFlag()
            break
        default:
            break
        }
        return reply
    }
}
