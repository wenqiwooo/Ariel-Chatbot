//
//  DataProcessor.swift
//  NPLModule
//
//  Created by Wu Wenqi on 10/6/15.
//  Copyright © 2015 SIA App Challenge. All rights reserved.
//

import Foundation

public class DataProcessor {
    
    func processStringForMain(s: String) -> [Double] {
        var tokens = self.tag(s, scheme: NSLinguisticTagSchemeLexicalClass)
        // var nouns = tokens.filter {$0.tag == "Noun"}
        // var pronouns = tokens.filter {$0.tag == "Pronoun"}
        
        // p[0]     connectivity
        // p[1]     consumption
        // p[2]     emergency
        // p[3]     flight
        // p[4]     lodging
        // p[5]     logistic
        // p[6]     shop
        // p[7]     transport
        // p[8]     weather
        
        var inputEntry: [Double] = [Double](count: N_INPUT_MAIN, repeatedValue: 0)
        
        for var i = 0; i < tokens.count; i++ {
            let t = tokens[i].token.lowercaseString
            if mainConnectivityWords.contains(t){
                inputEntry[0]++
            }
            if mainConsumptionWords.contains(t){
                inputEntry[1]++
            }
            if mainEmergencyWords.contains(t){
                inputEntry[2]++
            }
            if mainFlightWords.contains(t){
                inputEntry[3]++
            }
            if mainLodgingWords.contains(t){
                inputEntry[4]++
            }
            if mainLogisticWords.contains(t){
                inputEntry[5]++
            }
            if mainShopWords.contains(t){
                inputEntry[6]++
            }
            if mainTransportWords.contains(t){
                inputEntry[7]++
            }
            if mainWeatherWords.contains(t){
                inputEntry[8]++
            }
        }
        return inputEntry
    }
    
    func processStringForConsumptionModule(s: String) -> [Double]{
        // FOR CONSUMPTION
        /*
        [0]: show
        [1]: get
        [2]: food specific
        [3]: drink specific
        [4]: food generic
        [5]: drink generic
        [6]: hunger
        [7]: thirst
        [8]: positiveEmotion
        [9]: negativeEmotion
        */
        var tokens = self.tag(s, scheme: NSLinguisticTagSchemeLexicalClass)
        var inputEntry: [Double] = [Double](count: N_INPUT_CONSUMPTION, repeatedValue: 0)
        
        for var i = 0; i < tokens.count; i++ {
            let t = tokens[i].token.lowercaseString
            if consumptionShowWords.contains(t){
                inputEntry[0]++
            }
            if consumptionGetWords.contains(t){
                inputEntry[1]++
            }
            if consumptionFoodSpecificWords.contains(t){
                inputEntry[2]++
            }
            if consumptionDrinkSpecificWords.contains(t){
                inputEntry[3]++
            }
            if consumptionFoodGenericWords.contains(t){
                inputEntry[4]++
            }
            if consumptionDrinkGenericWords.contains(t){
                inputEntry[5]++
            }
            if consumptionHungerWords.contains(t){
                inputEntry[6]++
            }
            if consumptionThirstWords.contains(t){
                inputEntry[7]++
            }
            if consumptionPositiveWords.contains(t){
                inputEntry[8]++
            }
            if consumptionNegativeWords.contains(t){
                inputEntry[9]++
            }
        }
        return inputEntry
    }
    
    func tag(text: String, scheme: String) -> [TaggedToken] {
        let options: NSLinguisticTaggerOptions = [.OmitWhitespace, .OmitPunctuation, .OmitOther]
        let schemes = NSLinguisticTagger.availableTagSchemesForLanguage("en")
        let tagger = NSLinguisticTagger(tagSchemes: schemes,
            options: Int(options.rawValue))
        tagger.string = text
        
        var tokens: [TaggedToken] = []
        
        // Using NSLinguisticTagger
        tagger.enumerateTagsInRange(NSMakeRange(0, (text as NSString).length), scheme: scheme, options: options) { tag, tokenRange, _, _ in
            let token = (text as NSString).substringWithRange(tokenRange)
            tokens.append((token, tag))
        }
        return tokens
    }
    
}
