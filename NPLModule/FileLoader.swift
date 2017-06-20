//
//  FileLoader.swift
//  NPLModule
//
//  Created by Wu Wenqi on 10/6/15.
//  Copyright © 2015 SIA App Challenge. All rights reserved.
//

import Foundation

public class FileLoader {
    
    // Output declaration
    // [0]: Connectivity
    // [1]: Consumption
    // [2]: Emergency
    // [3]: Flight
    // [4]: Lodging
    // [5]: Logistic
    // [6]: Shop
    // [7]: Transport
    // [8]: Weather
    
    var dp: DataProcessor
    var mainDataSet: [DataEntry]

    init(path: String, ext: String, nOutput: Int, type: Int) {
        self.dp = DataProcessor()
        self.mainDataSet = [DataEntry]()
        
        let fileURL = NSBundle.mainBundle().URLForResource(path, withExtension: ext)
        
        var content: String = ""
        do {
            content = try String(contentsOfURL: fileURL!, encoding: NSUTF8StringEncoding)
        } catch {
            exit(0)
        }
        
        var lines = content.componentsSeparatedByString("\n")
        
        for var i = 0; i < lines.count - 1; i = i + 2 {
            var t: [Double] = [Double](count: nOutput, repeatedValue: 0)
            
            var p: [Double]
            switch type {
            case 0:
                p = dp.processStringForMain(lines[i])
                break
            case 1:
                p = dp.processStringForConsumptionModule(lines[i])
                break
            default:
                p = dp.processStringForMain(lines[i])
                break
            }
            
            var pt = lines[i + 1].componentsSeparatedByString(" ")
            for var j = 0; j < t.count; j++ {
                t[j] = Double(pt[j])!
            }
            
            let d = DataEntry(p: p, t: t)
            mainDataSet.append(d)
        }
        mainDataSet.shuffleInPlace()
    }
}