//
//  DataEntry.swift
//  NPLModule
//
//  Created by Wu Wenqi on 10/6/15.
//  Copyright © 2015 SIA App Challenge. All rights reserved.
//

import Foundation

public class DataEntry {
    var pattern: [Double]
    var target: [Double]
    
    init(p: [Double], t: [Double]){
        self.pattern = p
        self.target = t
    }
}
