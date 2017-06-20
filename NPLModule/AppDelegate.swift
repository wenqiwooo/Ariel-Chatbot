//
//  AppDelegate.swift
//  ChatApp
//
//  Created by mx on 6/10/15.
//  Copyright © 2015 mx. All rights reserved.
//

import UIKit
import Onboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func createIntroViewController() -> OnboardingViewController {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        let BLUE = UIColorFromHex(0x28AFFA)
        let bgImage = UIImage.withColor(BLUE)
        
        let img01 = UIImage(named: "img01")
        let page01: OnboardingContentViewController = OnboardingContentViewController(title: nil, body: "Hi, I'm Ariel, your \n personal flight assistant", image: img01, buttonText: nil) {
        }
        page01.iconWidth = 158
        page01.iconHeight = 258.5
        
        let img02 = UIImage(named: "img02")
        let page02: OnboardingContentViewController = OnboardingContentViewController(title: nil, body: "Message me here to \n order food and drinks", image: img02, buttonText: nil) {
        }
        page02.iconWidth = 158
        page02.iconHeight = 258.5
        
        let img03 = UIImage(named: "img03")
        let page03: OnboardingContentViewController = OnboardingContentViewController(title: nil, body: "You can also purchase \n WiFi in the conversation", image: img03, buttonText: nil) {
        }
        page03.iconWidth = 158
        page03.iconHeight = 258.5
        
        let img04 = UIImage(named: "img04")
        let page04: OnboardingContentViewController = OnboardingContentViewController(title: nil, body: "Feel free to talk to me \n about anything \n under the sun", image: img04, buttonText: "Get Started") {
            self.setupViewController(true)
        }
        page04.iconWidth = 158
        page04.iconHeight = 258.5
        
        // Creating the OnboardingViewController object to be returned
        let onboardingVC = OnboardingViewController(backgroundImage: bgImage, contents: [page01, page02, page03, page04])
        
        onboardingVC.fontName = "HelveticaNeue-Light"
        onboardingVC.bodyFontSize = 28
        onboardingVC.titleFontName = "HelveticaNeue-Bold"
        onboardingVC.titleFontSize = 22
        onboardingVC.buttonFontName = "HelveticaNeue-Bold"
        onboardingVC.buttonFontSize = 24
        onboardingVC.topPadding = 10+(self.window!.frame.height/12)
        onboardingVC.bottomPadding = 80
        onboardingVC.underTitlePadding = 8
        onboardingVC.shouldMaskBackground = false
        
        return onboardingVC
    }
    
    
    // Somehow this worked so I should be very happy...
    func setupViewController(animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ViewController = storyboard.instantiateInitialViewController()
        
        if animated {
            UIView.transitionWithView(self.window!, duration: 0.5, options:UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                self.window!.rootViewController = ViewController
                }, completion:nil)
        } else {
            self.window?.rootViewController = ViewController
        }
        self.window!.makeKeyAndVisible() // don't know what makeKeyAndVisible does
    }
    
    // Modified to setup the IntroViewController
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window!.rootViewController = createIntroViewController()
        self.window!.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

