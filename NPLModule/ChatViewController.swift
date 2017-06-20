//
//  ViewController.swift
//  SyncanoChat
//
//  Created by mx on 6/10/15.
//  Copyright © 2015 mx. All rights reserved.
//

// TODO
// 1. Be able to send a POST request to the backend
//  1.1 Request for items (standard procedures)
//  1.2 Ask for human operator to handle the request. Need to pass user message along
// 2. Handle interfacing between user and parsing (bot) library
//  2.1 Show user message bubbles [DONE]
//  2.2 Show bot reply bubbles
// 3. Set up identities
//  3.1 Set up user identity
//  3.2 Set up bot identity
// 4. Settle UI
//  4.1 Set up header bar (ask Wenqi) [DONE]
//  4.2 Set up scenes where user gets to enter his credentials 
//  4.3 Decide on the final UI

// USER FLOW
// 1. Get Name
// 2. Get Seat number
// 3. OK you can start chatting now

import UIKit
import Alamofire
import JSQMessagesViewController
import SwiftyJSON

class ChatViewController: JSQMessagesViewController {
    // Properties
    var userName = "" // will get from user (how do I pass this string from somewhere else?)
    var messages = [JSQMessage]() // Swift way of initialising an array of ['a]
    
    var fl: FileLoader
    var dp: DataProcessor
    var rp: RequestProcessor
    var db: Dashboard
    var updateRequestFlag: Bool
    
    private var callback: (()->Void)?;
    private var timer = NSTimer();
    
    // Set bubble colours (need to explore more of these options)
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())

    // I don't understand why I cannot seperate out the image factory code
    // http://stackoverflow.com/questions/32540878/swift-2-0-map-instance-member-cannot-be-used-on-type
//    let avatar = JSQMessagesAvatarImage(placeholder: JSQMessagesAvatarImageFactory.circularAvatarImage(UIImage(named: "AppAvatar"), withDiameter: 30))
//    
//    let foo = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials("JSQ", backgroundColor: UIColor(white: 0.60, alpha: 1.0), textColor: UIColor(white: 0.60, alpha: 1.0), font: UIFont.systemFontOfSize(CGFloat(13)), diameter: 34)
    
    required init(coder aDecoder: NSCoder) {
        self.fl = FileLoader(path: "main_dataset", ext: "", nOutput: N_OUTPUT_MAIN, type: 0)
        self.dp = DataProcessor()
        self.rp = RequestProcessor()
        self.db = Dashboard()
        self.updateRequestFlag = false
        
        super.init(coder: aDecoder)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*

    Custom methods
    
    */
    
    func punchMX(){
        print("ouch")
    }
    
    func sendMessage(body: String, senderId: String) {
    }
    
    func parseMessage(text: String) -> String {
        // Wenqi's bot here
        let reply = rp.sendForMain(rp.processForMain(dp.processStringForMain(text)), s:text)
        return reply
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        // TODO: the printing of the response doesn't work yet.
        let url = "https://awesome-sia.eu-gb.mybluemix.net/api/requests"
        Alamofire.request(.GET, url)
            .responseJSON { response  in
        }
        
        // Removes the attachment button
        self.inputToolbar?.contentView?.leftBarButtonItem = nil
        
        // Removes avatar
        self.collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
        self.collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
        
        // TODO: get this from the user input
        self.userName = "iPhone" // going to delete this soon, should receive information from viewcontroller
        
        // Seeding with sample data
        let welcomeMessage = JSQMessage(senderId: "Ariel", displayName: "Ariel", text: "Hi, I'm Ariel, your intelligent in-flight personal assistant. Ask me here if you need anything. Hope you have a good flight!")
        self.messages += [welcomeMessage]
        
        self.collectionView!.reloadData()
        self.senderDisplayName = self.userName
        self.senderId = self.userName

        self.db.startRequestingStatus(self.followUpRequest)
    }
    
    func followUpRequest(){
        self.updateRequestFlag = true;
        var replyText = "Your request has been seen by my colleague. Please wait a while longer."
        var reply = JSQMessage(senderId: "other", displayName: "other", text: replyText)
        self.replyMessage(reply)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        if (user.updatedWifiFlag == true){
            var replyText = "Your SITAONAIR in-flight wifi voucher code is " + user.wifiKey + ". Enter the wifi voucher code at http://oa-nxt.demo.onair.aero/OA/en/mobile to get internet access."
            var reply = JSQMessage(senderId: "other", displayName: "other", text: replyText)
            self.replyMessage(reply)
        }
    }

    /*

    UICollectionViewDataSource overrides
    The data source object represents your app’s messaging data model and vends information to the collection view as needed.

    */
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellBottomLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        return NSAttributedString(string: "foobar")
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        let data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let data = self.messages[indexPath.row]
        if data.senderId == self.senderId {
            return self.outgoingBubble
        } else {
            return self.incomingBubble
        }
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        if message.senderId == self.senderId {
            cell.textView!.textColor = UIColor.whiteColor()
        } else {
            cell.textView!.textColor = UIColor.blackColor()
        }
        return cell
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
//        let message = messages[indexPath.item]
//        if message.senderId == self.senderId {
//            return foo
//        } else {
//            return avatar
//        }
        return nil
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func replyMessage(message: JSQMessage) {
        var replyMessage: JSQMessage
        if (self.updateRequestFlag == true){
            self.updateRequestFlag = false
            replyMessage = message
        } else if (user.updatedWifiFlag == true){
            replyMessage = message
            user.unsetUpdatedWifiFlag()
        } else {
            let text = parseMessage(message.text)
            replyMessage = JSQMessage(senderId: "Other", displayName: "Other", text: text)
        }
        messages += [replyMessage]

        self.showTypingIndicator = !self.showTypingIndicator
        self.scrollToBottomAnimated(true)
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            //put your code which should be executed with a delay here
            self.showTypingIndicator = !self.showTypingIndicator
            self.finishSendingMessage()
        }
        
        if (user.purchaseFlag == true){
            user.unsetPurchaseFlag()
            self.performSegueWithIdentifier("purchaseWifi", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "purchaseWifi" {
            
        }
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        let newMessage = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        messages += [newMessage]
        self.finishSendingMessage()
        replyMessage(newMessage)
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        
    }
    
    /*
    
    UICollectionViewDelegateFlowLayout overrides
    Allows you to manage additional layout information for the collection view and respond to additional actions on its items
    
    */
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 10
    }
    
    
    
    
    
    
}

