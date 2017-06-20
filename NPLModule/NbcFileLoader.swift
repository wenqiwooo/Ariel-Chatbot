//
//  NbcFileLoader.swift
//  NPLModule
//
//  Created by Wu Wenqi on 10/7/15.
//  Copyright © 2015 SIA App Challenge. All rights reserved.
//

import Foundation


public class NbcFileLoader {
    
    // Output declaration for Consumption
    // [0]: Show menu
    // [1]: Show drinks
    // [2]: Get specific food
    // [3]: Get specific drink
    // [4]: Prompt food (get)
    // [5]: Prompt drink (get)
    // [6]: Positive feedback
    // [7]: Negative feedback
    
    var dp: DataProcessor
    var dataSet: [NbcDataEntry]
    
    init(path: String, ext: String) {
        self.dp = DataProcessor()
        self.dataSet = [NbcDataEntry]()
        
        let fileURL = NSBundle.mainBundle().URLForResource(path, withExtension: ext)
        
        var content: String = ""
        do {
            content = try String(contentsOfURL: fileURL!, encoding: NSUTF8StringEncoding)
        } catch {
            exit(0)
        }
        
        var lines = content.componentsSeparatedByString("\n")
        
        for var i = 0; i < lines.count; i++ {
            var c = lines[i].characters.last!
            var t = String(lines[i].characters.dropLast())
            let d = NbcDataEntry(t: t, c: String(c))
            self.dataSet.append(d)
        }
        self.dataSet.shuffleInPlace()
    }
}