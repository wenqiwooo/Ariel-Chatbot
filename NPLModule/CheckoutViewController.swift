//
//  CheckoutTableViewController.swift
//  NPLModule
//
//  Created by Wu Wenqi on 10/8/15.
//  Copyright © 2015 SIA App Challenge. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController, SIMChargeCardViewControllerDelegate {
    
    func goToMasterCard() {
        var chargeVC:SIMChargeCardViewController = SIMChargeCardViewController.init(publicKey: "sbpb_MGU4MWQ5Y2ItMGI1Ny00MDhjLWEyMzEtMzhmMTBhMTlkMDZh")
        
        chargeVC.delegate = self
        self.presentViewController(chargeVC, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let BLUE = UIColorFromHex(0x28AFFA)
        self.view.backgroundColor = BLUE
        
        let confirmMessage = UILabel(frame: CGRect(x: self.view.frame.size.width/2-150, y: 150, width: 300, height: 200))
        confirmMessage.text = "Do you want to \n proceed to payment?"
        confirmMessage.font = UIFont(name: confirmMessage.font.fontName, size: 28)
        confirmMessage.numberOfLines = 2
        confirmMessage.textAlignment = .Center
        confirmMessage.textColor = UIColor.whiteColor()
        
        let proceed = UIButton(frame: CGRect(x: self.view.frame.size.width/2-75, y: 300, width: 150, height: 60))
        proceed.backgroundColor = UIColorFromHex(0xffda2c)
        proceed.layer.cornerRadius = 30
        proceed.setTitle("Proceed", forState: .Normal)
        proceed.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        proceed.addTarget(self, action: "goToMasterCard", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(proceed)
        self.view.addSubview(confirmMessage)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func creditCardTokenProcessed(token: SIMCreditCardToken!) {
        
        var url: NSURL = NSURL.init(string: "https://ariel-sia.herokuapp.com/charge.php")!
        var request: NSMutableURLRequest = NSMutableURLRequest.init(URL: url, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.HTTPMethod = "POST"
        var postString = "simplifyToken="
        postString = postString.stringByAppendingString(token.token)
        postString = postString.stringByAppendingString("&amount=1000")
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            print("response = \(response)")
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            
            // Give user wifi
            url = NSURL.init(string: "http://57.191.0.124/ProviderProxy/Promotions/promocode/OnAir_100MB")!
            var getWifiRequest: NSMutableURLRequest = NSMutableURLRequest.init(URL: url, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 50.0)
            getWifiRequest.HTTPMethod = "GET"
            getWifiRequest.setValue("application/json", forHTTPHeaderField: "Accept")
            getWifiRequest.setValue("bb11252a491d04006f318180ab5cf559", forHTTPHeaderField: "X-apiKey")
            
            let getWifiTask = NSURLSession.sharedSession().dataTaskWithRequest(getWifiRequest) {
                data, response, error in
                
                if error != nil {
                    print("error=\(error)")
                    return
                }
                
                print("response = \(response)")
                
                do {
                    let responseString = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                    print("responseString = \(responseString)")
                
                    user.wifiKey = responseString?.valueForKey("promocode") as! String
                    user.setUpdatedWifiFlag()
                } catch {
                    
                }
            }
            
            getWifiTask.resume()
            
        }
        
        task.resume()
    }
    
    func creditCardTokenFailedWithError(error: NSError!) {
        print(error.description)
    }
    
    func chargeCardCancelled() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
