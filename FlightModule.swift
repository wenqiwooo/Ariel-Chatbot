//
//  FlightModule.swift
//  NPLModule
//
//  Created by Wu Wenqi on 10/7/15.
//  Copyright © 2015 SIA App Challenge. All rights reserved.
//

import Foundation

public class FlightModule {
    
    private class CrewData {
        typealias Crew = (name: String, designation: String, role: String)
        var crews: [Crew]
        
        init(){
            crews = [Crew]()
        }
        
        func add(name: String, designation: String, role: String){
            let crew: Crew = (name: name, designation: designation, role: role)
            crews.append(crew)
        }
    }
    
    init() {
        
    }
    
    func request(x: Int) -> String {
        
        // Output declaration for Flight
        // [0]: General
        // [1]: Arrival
        // [2]: Departure
        // [3]: Crew
        
        var reply = ""
        switch x {
        case 0:
            reply += "Here is the flight information. You are currently on flight SQ711, en route to L.A., estimated time of arrival will be 3pm evening."
            break
        case 1:
            reply += "You will be landing at your destination at 3pm sharp."
            break
        case 2:
            reply += "You departed from Singapore Changi Airport at 12am."
            break
        case 3:
            reply += "Here is our crew information."
            break
        default:
            break
        }
        return reply
    }
}
