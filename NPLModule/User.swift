//
//  User.swift
//  NPLModule
//
//  Created by Wu Wenqi on 10/9/15.
//  Copyright © 2015 SIA App Challenge. All rights reserved.
//

import Foundation


public class User {
    // State category flags
    // [0]: Connectivity
    // [1]: Consumption
    // [2]: Emergency
    // [3]: Flight
    // [4]: Lodging
    // [5]: Logistic
    // [6]: Shop
    // [7]: Transport
    // [8]: Weather
    
    var isSetFlag: Bool
    var categoryFlags: [Bool]
    var affirmationFlag: Bool
    var affirmationText: String
    var purchaseFlag: Bool
    var name: String
    var seatNumber: String
    var flight: String
    var wifiKey: String
    var updatedWifiFlag: Bool
    var requestId: String
    var pendingRequestFlag: Bool
    
    init() {
        self.isSetFlag = false
        self.categoryFlags = [Bool](count: 9, repeatedValue: false)
        self.name = ""
        self.seatNumber = ""
        self.flight = "SQ321"
        self.affirmationFlag = false
        self.affirmationText = ""
        self.purchaseFlag = false
        self.wifiKey = ""
        self.updatedWifiFlag = false
        self.requestId = ""
        self.pendingRequestFlag = false
    }
    
    func setPendingRequestFlag(){
        self.pendingRequestFlag = true
    }
    
    func unsetPendingRequestFlag(){
        self.pendingRequestFlag = false
    }
    
    func setAffirmationText(s: String){
        self.affirmationText = s
    }
    
    func setUpdatedWifiFlag(){
        self.updatedWifiFlag = true
    }
    
    func unsetUpdatedWifiFlag(){
        self.updatedWifiFlag = false
    }
    
    func setName(s: String){
        self.name = s
    }
    
    func setSeatNumber(s: String){
        self.seatNumber = s
    }
    
    func setPurchaseFlag(){
        self.purchaseFlag = true
    }
    
    func unsetPurchaseFlag(){
        self.purchaseFlag = false
    }
    
    func setAffirmationFlag(){
        self.affirmationFlag = true
    }
    
    func unsetAffirmationFlag(){
        self.affirmationFlag = false
    }
    
    func getSelectedCategoryFlag() -> Int {
        for var i = 0; i < self.categoryFlags.count; i++ {
            if (self.categoryFlags[i] == true){
                return i
            }
        }
        return -1
    }
    
    func setSelectedCategoryFlag(x: Int){
        self.unsetAllCategoryFlags()
        self.categoryFlags[x] = true
    }
    
    func unsetAllCategoryFlags(){
        for var i = 0; i < self.categoryFlags.count; i++ {
            self.categoryFlags[i] = false
        }
    }
}