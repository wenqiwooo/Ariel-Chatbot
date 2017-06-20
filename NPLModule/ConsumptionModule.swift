//
//  ConsumableModule.swift
//  NPLModule
//
//  Created by Wu Wenqi on 10/6/15.
//  Copyright © 2015 SIA App Challenge. All rights reserved.
//

import Foundation

public class ConsumptionModule {
    
    private class MenuSet {
        var starterSet: [String]
        var mainSet: [String]
        var finaleSet: [String]
        
        init() {
            self.starterSet = [String]()
            self.mainSet = [String]()
            self.finaleSet = [String]()
        }
        
        func addStarter(s: String){
            self.starterSet.append(s)
        }
        
        func addMain(s: String){
            self.mainSet.append(s)
        }
        
        func addFinale(s: String){
            self.finaleSet.append(s)
        }
    }
    
    private var menu: MenuSet
    private var drinks: [String]
    
    init() {
        self.menu = MenuSet()
        menu.addStarter("Tian of crab with apple and mozzarella with cherry tomato")
        menu.addMain("Roasted halibut fillet in clam chowder with bacon and potato, sauteed spinach")
        menu.addMain("Braised lamb shank in red wine with baby vegetables and ratatouille")
        menu.addMain("Braised shanghainese style pork rib with vegetables and local noodles")
        menu.addFinale("Citrus creme brulee")
        menu.addFinale("Mango ice cream with passionfruit coulis")
        menu.addFinale("Gourmet cheese with garnishes")
        menu.addFinale("A selection of fresh fruit")
        menu.addFinale("Gourmet coffees & selection of fine teas, with pralines")

        self.drinks = ["coke", "sprite", "juice", "gingerale", "coffee", "tea"]
    }
    
    // Output declaration for Consumption
    // [0]: Show menu
    // [1]: Show drinks
    // [2]: Get specific food
    // [3]: Get specific drink
    // [4]: Prompt food (get)
    // [5]: Prompt drink (get)
    // [6]: Positive feedback
    // [7]: Negative feedback
    
    func requestSpecific(s: String) -> String {
        var foodRequest = self.requestSpecificFood(s)
        if (foodRequest["result"] == "1"){
            user.setAffirmationFlag()
            return foodRequest["reply"]!
        } else {
            var drinkRequest = self.requestSpecificDrink(s)
            if (drinkRequest["result"] == "!"){
                user.setAffirmationFlag()
            }
            return drinkRequest["reply"]!
        }
    }
    
    func requestSpecificFood(s: String) -> [String: String] {
        var words = s.lowercaseString.componentsSeparatedByString(" ")
        var index = -1
        let menuItems = self.menu.starterSet + self.menu.mainSet + self.menu.finaleSet
        
        for var i = 0; i < menuItems.count; i++ {
            if (index >= 0){
                break
            }
            
            var f = menuItems[i].lowercaseString.componentsSeparatedByString(" ")
            
            for var j = 0; j < words.count; j++ {
                if (f.contains(words[j])){
                    index = i
                    break
                }
            }
        }
        
        if (index < 0){
            // var randInt = Int(arc4random_uniform(UInt32(menuItems.count)))
            let reply = "Sorry I can't find that on board the plane."
            return ["result": "0", "reply": reply]
        } else {
            let reply = "Do you mean " + menuItems[index].lowercaseString + "?"
            user.setAffirmationText("Requested " + menuItems[index].lowercaseString)
            return ["result": "1", "reply": reply]
        }
    }
    
    func requestSpecificDrink(s: String) -> [String: String] {
        var words = s.lowercaseString.componentsSeparatedByString(" ")
        var index = -1
        for var i = 0; i < self.drinks.count; i++ {
            if (index >= 0){
                break
            }
            
            for var j = 0; j < words.count; j++ {
                if (self.drinks.contains(words[j])){
                    index = i
                    break
                }
            }
        }

        if (index < 0){
            // var randInt = Int(arc4random_uniform(UInt32(self.drinks.count)))
            let reply = "Sorry I can't find that on board the plane."
            return ["result": "0", "reply": reply]
        } else {
            let reply = "Just double checking, you want a " + self.drinks[index].lowercaseString + "?"
            user.setAffirmationText("Requested " + self.drinks[index].lowercaseString)
            return ["result": "1", "reply": reply]
        }
    }
    
    func request(x: Int) -> String {
        var reply = ""
        switch x {
        case 0:
            reply += self.getMenuInfo()
            break
        case 1:
            reply += self.getDrinksInfo()
            break
        case 2:
            reply += "Specific food"
            break
        case 3:
            reply += "Specific drink"
            break
        case 4:
            reply += "Oh dear. Allow me to get you something to eat."
            break
        case 5:
            reply += "Oh dear. Get a drink from me."
            break
        case 6:
            reply += "I'm glad to hear that. Thank you."
            break
        case 7:
            reply += "I'm sorry to hear that. Thanks for the feedback."
            break
        default:
            reply += "I am afraid I don't understand."
        }
        return reply
    }
    
    func getMenuInfo() -> String {
        var reply = "Here's what we are serving."
        reply += "\n\nStarter"
        for var i = 0; i < self.menu.starterSet.count; i++ {
            reply += "\n" + self.menu.starterSet[i]
        }
        reply += "\n\nMain"
        for var i = 0; i < self.menu.mainSet.count; i++ {
            reply += "\n" + self.menu.mainSet[i]
        }
        reply += "\n\nFinale"
        for var i = 0; i < self.menu.finaleSet.count; i++ {
            reply += "\n" + self.menu.finaleSet[i]
        }
        return reply
    }
    
    func getDrinksInfo() -> String {
        var reply = "Here are the drinks we have.\n"
        for var i = 0; i < self.drinks.count; i++ {
            reply += "\n" + self.drinks[i].capitalizedString
        }
        return reply
    }
    
}