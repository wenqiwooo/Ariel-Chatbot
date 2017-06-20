//
//  Dashboard.swift
//  NPLModule
//
//  Created by John Yong on 9/10/15.
//  Copyright © 2015 SIA App Challenge. All rights reserved.
//

import Foundation
import Alamofire

// Example to send message:
//let dashboard = Dashboard();
//dashboard.sendMessage("SQ321", seat: "56K", name: "iOS", message: "From app", category: "cool");
//
//func handleDone() {
//    print("Done");
//}
//dashboard.startRequestingStatus(handleDone);

public class Dashboard: NSObject {
    override init() {
        super.init()
    }
    var messageId = ""
    private var callback: (()->Void)?
    private var timer = NSTimer()
    
    func sendMessage(flight: String, seat: String, name: String, message: String, category: String) {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        let params:[String: AnyObject] = [
            "flight" : flight,
            "seat" : seat,
            "name" : name,
            "message" : message,
            "category" : category
        ]
        
        let url = NSURL(string:"http://awesome-sia.eu-gb.mybluemix.net/api/requests")
        let request = NSMutableURLRequest(URL: url!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        do {
            try request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions())
        } catch {
            
        }
        
        let task = session.dataTaskWithRequest(request) {
            data, response, error in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    print("response was not 200: \(response)")
                    return
                }
            }
            if (error != nil) {
                print("error submitting request: \(error)")
                return
            }
            
            // handle the data of the successful response here
            user.pendingRequestFlag = true
            self.messageId = NSString(data: data!, encoding: NSUTF8StringEncoding)! as String
            user.requestId = self.messageId
            print(self.messageId)
        }
        task.resume()
    }
    
    func startRequestingStatus(callback: (()->Void)) {
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "requestStatus", userInfo: nil, repeats: true)
        self.callback = callback
    }
    
    func requestStatus() {
        if (user.requestId != "") {
            Alamofire.request(.GET, "http://awesome-sia.eu-gb.mybluemix.net/api/requests/done", parameters: ["id": user.requestId])
                .responseString { response in
                    print(response.result.value)
                    if (response.result.value != "false") {
                        self.callback?()
                        user.requestId = ""
                        //self.timer.invalidate()
                    }
            }
        }
    }
    
}