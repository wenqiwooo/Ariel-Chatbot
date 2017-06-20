//
//  ViewController.swift
//  ChatApp
//
//  Created by mx on 8/10/15.
//  Copyright © 2015 mx. All rights reserved.
//

import UIKit
import Onboard
import TextFieldEffects

class RegisterViewController: UIViewController, UITextFieldDelegate {
    var onboardingViewController: OnboardingContentViewController?
    
    var arielLogo: UIImage
    var arielImage: UIImageView
    var username: UITextField
    var seatNumber: UITextField
    var proceed: UIButton
    
    required init(coder aDecoder: NSCoder) {
        
        self.arielLogo = UIImage(named: "ariellogo.png")!
        self.arielImage = UIImageView(image: self.arielLogo)
        self.username = UITextField()
        self.seatNumber = UITextField()
        self.proceed = UIButton()
        
        super.init(coder: aDecoder)!
    }
    
    func goToChat() {
        user.name = self.username.text!
        user.seatNumber = self.seatNumber.text!
        user.isSetFlag = true
        self.performSegueWithIdentifier("showChat", sender: self)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        username.resignFirstResponder()
        seatNumber.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        username.resignFirstResponder()
        seatNumber.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let BLUE = UIColorFromHex(0x28AFFA)
        self.view.backgroundColor = BLUE
        
        username.delegate = self
        seatNumber.delegate = self
        
        // Declared already
        // let arielLogo = UIImage(named: "ariellogo.png")
        // let arielImage = UIImageView(image: arielLogo)
        arielImage.frame.origin.x = self.view.frame.size.width/2-75
        arielImage.frame.origin.y = 200
        
        username = UITextField(frame: CGRect(x: self.view.frame.size.width/2-150, y: 310, width: 300, height: 40))
        username.backgroundColor = UIColor.whiteColor()
        username.layer.cornerRadius = 15
        username.textAlignment = .Center
        username.attributedPlaceholder = NSAttributedString.init(string: "Name")
        username.endEditing(true)
        
        seatNumber = UITextField(frame: CGRect(x: self.view.frame.size.width/2-150, y: 370, width: 300, height: 40))
        seatNumber.backgroundColor = UIColor.whiteColor()
        seatNumber.layer.cornerRadius = 15
        seatNumber.textAlignment = .Center
        seatNumber.attributedPlaceholder = NSAttributedString.init(string: "Seat Number")
        seatNumber.endEditing(true)
        
        proceed = UIButton(frame: CGRect(x: self.view.frame.size.width/2-75, y: 430, width: 150, height: 60))
        proceed.backgroundColor = UIColorFromHex(0xffda2c)
        proceed.layer.cornerRadius = 30
        proceed.setTitle("Chat Now", forState: .Normal)
        proceed.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        proceed.addTarget(self, action: "goToChat", forControlEvents: UIControlEvents.TouchUpInside)

        self.view.addSubview(username)
        self.view.addSubview(seatNumber)
        self.view.addSubview(arielImage)
        self.view.addSubview(proceed)

        
        
        

        
        
//        myField.borderStyle = UITextBorderStyle.Line
//        myField.text = "myString"
//        myField.backgroundColor = UIColor.redColor()
//        
//        var fieldFrame = myField.frame
//        fieldFrame.origin.x = 300
//        fieldFrame.origin.y = 200
//        myField.frame = fieldFrame
        
//        self.view.addSubview(myField)
//        print("THIS IS REGISTER VIEW CONTROLLER")

        
//        
//        let anotherText = KaedeTextField(frame: CGRect(x: 20, y: 20, width: 200, height: 40))
//        anotherText.foregroundColor = UIColor.whiteColor()
//        var fieldFrame  = anotherText.frame
//        fieldFrame.origin.x = 100
//        fieldFrame.origin.y = 200
//        anotherText.frame = fieldFrame
//        self.view.addSubview(anotherText)
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if (user.name != ""){
            self.username.text = user.name
        }
        if (user.seatNumber != ""){
            self.seatNumber.text = user.seatNumber
        }
        if (user.isSetFlag == true){
            self.proceed.titleLabel?.text = "  Update"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func introComplete() {
        onboardingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    let firstPage = OnboardingContentViewController(title: "Page Title", body: "Page body goes here.", image: UIImage(named: "icon"), buttonText: "Text For Button") { () -> Void in
        // do something here when users press the button, like ask for location services permissions, register for push notifications, connect to social media, or finish the onboarding process
        print("hello world!")
    }
    
    
}
