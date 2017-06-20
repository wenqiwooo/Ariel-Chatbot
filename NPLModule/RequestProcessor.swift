//
//  RequestProcessor.swift
//  NPLModule
//
//  Created by Wu Wenqi on 10/6/15.
//  Copyright © 2015 SIA App Challenge. All rights reserved.
//

import Foundation

public class RequestProcessor {

    var dp: DataProcessor
    
    var connectivityM: ConnectivityModule
    var nbcConnectivity: NaiveBayesClassifier
    var nbcFlConnectivity: NbcFileLoader
    
    var consumptionM: ConsumptionModule
    var nbcConsumption: NaiveBayesClassifier
    var nbcFlConsumption: NbcFileLoader
    
    var flightM: FlightModule
    var nbcFlight: NaiveBayesClassifier
    var nbcFlFlight: NbcFileLoader
    
    // Output declaration for Main
    // [0]: Connectivity
    // [1]: Consumption
    // [2]: Emergency
    // [3]: Flight
    // [4]: Lodging
    // [5]: Logistic
    // [6]: Shop
    // [7]: Transport
    // [8]: Weather
    
    init(){
        self.dp = DataProcessor()
        
        self.consumptionM = ConsumptionModule()
        self.nbcConsumption = NaiveBayesClassifier { (text: String) -> [String] in
            return lemmatize(text).map { (token, tag) in
                return tag ?? token
            }
        }
        self.nbcFlConsumption = NbcFileLoader(path: "consumption_dataset_bc", ext: "")
        let consumptionTrainingSet = self.nbcFlConsumption.dataSet
        
        for var i = 0; i < consumptionTrainingSet.count; i++ {
            let data = consumptionTrainingSet[i]
            var text = data.text
            var cat = data.category
            self.nbcConsumption.trainWithText(text, category: cat)
        }
        
        self.connectivityM = ConnectivityModule()
        self.nbcConnectivity = NaiveBayesClassifier { (text: String) -> [String] in
            return lemmatize(text).map { (token, tag) in
                return tag ?? token
            }
        }
        self.nbcFlConnectivity = NbcFileLoader(path: "connectivity_dataset_bc", ext: "")
        let connectivityTrainingSet = self.nbcFlConnectivity.dataSet
        
        for var i = 0; i < connectivityTrainingSet.count; i++ {
            let data = connectivityTrainingSet[i]
            var text = data.text
            var cat = data.category
            self.nbcConnectivity.trainWithText(text, category: cat)
        }
        
        self.flightM = FlightModule()
        self.nbcFlight = NaiveBayesClassifier { (text: String) -> [String] in
            return lemmatize(text).map { (token, tag) in
                return tag ?? token
            }
        }
        self.nbcFlFlight = NbcFileLoader(path: "flight_dataset_bc", ext: "")
        let flightTrainingSet = self.nbcFlFlight.dataSet
        
        for var i = 0; i < flightTrainingSet.count; i++ {
            let data = flightTrainingSet[i]
            var text = data.text
            var cat = data.category
            self.nbcFlight.trainWithText(text, category: cat)
        }
    }
    
    
    func processForMain(o: [Double]) -> [String: Int] {
        var max = 0
        for var i = 0; i < o.count; i++ {
            if (o[i] > o[max]){
                max = i
            }
        }
        if (o[max] == 0){
            max = -1
        }
        return ["category": max]
    }
    
    func sendForMain(r: [String: Int], s: String) -> String{
        
        var reply = ""
        
        // Check if user is requesting for personal info
        var name: String
        var seatNumber: String
        var flight: String
        var wifiKey: String
        
        var checkUserFlag = false
        for var i = 0; i < userWords.count; i++ {
            let w = "my " + userWords[i]
            if (s.lowercaseString.rangeOfString(w) != nil){
                checkUserFlag = true
            }
        }
        
        if (checkUserFlag){
            if (s.lowercaseString.rangeOfString("name") != nil){
                reply += "Your name is " + user.name + ". Is that a test?"
            } else if (s.lowercaseString.rangeOfString("seat") != nil){
                reply += "Your seat number is " + user.seatNumber
            } else if (s.lowercaseString.rangeOfString("flight") != nil){
                reply += "Your flight number is " + user.flight
            } else {
                if (user.wifiKey == ""){
                    reply += "Oh no, seems like you don't have any SITAONAIR wifi sessions. Request me for one!"
                } else {
                    reply += "Your SITAONAIR in-flight voucher code is " + user.wifiKey + ". Enter the wifi voucher code at http://oa-nxt.demo.onair.aero/OA/en/mobile to get internet access."
                }
            }
            return reply
        }
        
        // Check if system is waiting for an affirmation from user
        if (user.affirmationFlag == true){
            var x = user.getSelectedCategoryFlag()
            var words = s.componentsSeparatedByString(" ")

            var affirm: Bool = false
            var deny: Bool = false
            
            for var i = 0; i < words.count; i++ {
                let w = words[i].lowercaseString
                if affirmWords.contains(w){
                    affirm = true
                }
                if denyWords.contains(w){
                    deny = true
                }
                if (affirm && deny){
                    break
                }
            }
            
            if (affirm && deny){
                reply += "I'm sorry but I can't quite understand. Please be clearer."
                return reply
            }
            
            if (!affirm && !deny){
                reply += "Can you answer the previous question?"
                return reply
            }
            
            switch x {
            case 0:
                // Connectivity
                if (affirm){
                    reply += "Alright, I will get you the wifi."
                    user.setPurchaseFlag()
                } else {
                    reply += "Alright then. It's a no for now I guess,"
                }
                break
            case 1:
                // Consumption
                if (affirm){
                    reply += "Alright, I will let my colleagues know."
                    let db = Dashboard()
                    db.sendMessage(user.flight, seat: user.seatNumber, name: user.name, message: user.affirmationText, category: "Consumption")
                } else {
                    reply += "No worries. Do try our food when you are hungry"
                }
                break
            case 2:
                break
            case 3:
                break
            case 4:
                break
            case 5:
                break
            case 6:
                break
            case 7:
                break
            case 8:
                break
            default:
                break
            }
            user.unsetAffirmationFlag()
            return reply
        }
        
        switch r["category"]! {
        case -1:
            // This is when the user input cannot be classified.
            
            if (self.checkStringContainArraySubstring(greetingWords, s: s) == true){
                var randIndex = Int(arc4random_uniform(UInt32(greetingReplies.count)))
                reply += greetingReplies[randIndex]
            } else if (self.checkStringContainArraySubstring(farewellWords, s: s) == true){
                var randIndex = Int(arc4random_uniform(UInt32(farewellReplies.count)))
                reply += farewellReplies[randIndex]
            } else {
                var randIndex = Int(arc4random_uniform(UInt32(statements.count)))
                reply += statements[randIndex]
            }
            break
        case 0:
            // Output declaration for Connectivity
            // [0]: Usage
            // [1]: Pricing
            // [2]: Purchase
            let output = self.nbcConnectivity.classifyText(s)!
            print(output)
            reply += connectivityM.request(Int(output)!)
            user.setSelectedCategoryFlag(0)
            break
        case 1:
            // Output declaration for Consumption
            // [0]: Show menu
            // [1]: Show drinks
            // [2]: Get specific food
            // [3]: Get specific drink
            // [4]: Prompt food (get)
            // [5]: Prompt drink (get)
            // [6]: Positive feedback
            // [7]: Negative feedback
            
            // Check not in consumption generic list.
            // If so, check menu for item
            var isGeneric: Bool = false
            var words = s.componentsSeparatedByString(" ")
            
            for var i = 0; i < words.count; i++ {
                if (consumptionFoodGenericWords.contains(words[i].lowercaseString) || consumptionDrinkGenericWords.contains(words[i].lowercaseString)){
                    isGeneric = true
                    break
                }
            }
            
            if (isGeneric){
                let output = self.nbcConsumption.classifyText(s)!
                print(output)
                reply += consumptionM.request(Int(output)!)
            } else {
                reply += consumptionM.requestSpecific(s)
            }
            user.setSelectedCategoryFlag(1)
            break
        case 2:
            // run EmergencyModule
            reply += "Sorry I have yet to attend my first-aid training."
            user.setSelectedCategoryFlag(2)
            break
        case 3:
            // Output declaration for Flight
            // [0]: General
            // [1]: Arrival
            // [2]: Source
            // [3]: Crew
            let output = self.nbcFlight.classifyText(s)!
            print(output)
            reply += flightM.request(Int(output)!)
            user.setSelectedCategoryFlag(3)
            break
        case 4:
            // run LodgingModule
            reply += "Sorry I don't know enough about lodging to help you yet."
            user.setSelectedCategoryFlag(4)
            break
        case 5:
            // run LogisticModule
            reply += "Sorry I don't know enough about logistic to help you yet."
            user.setSelectedCategoryFlag(5)
            break
        case 6:
            // run ShopModule
            reply += "Sorry I don't know enough about shopping to help you yet."
            user.setSelectedCategoryFlag(6)
            break
        case 7:
            // run TransportModule
            reply += "Sorry I don't know enough about transportation to help you yet."
            user.setSelectedCategoryFlag(7)
            break
        case 8:
            // run WeatherModule
            reply += "Sorry I don't know enough about the weather to help you yet."
            user.setSelectedCategoryFlag(8)
            break
        default:
            break
        }
        return reply
    }
    
    func checkStringContainArraySubstring(arr: [String], s: String) -> Bool {
        for var i = 0; i < arr.count; i++ {
            if (s.lowercaseString.rangeOfString(arr[i]) != nil){
                return true
            }
        }
        return false
    }
    
}
