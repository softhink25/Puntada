//
//  AppDelegate.swift
//  Puntada
//
//  Created by Luis Ibarra on 10/14/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UIKit
import FBSDKCoreKit
import GoogleSignIn
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    var window: UIWindow?
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
          if(error != nil){
            return;
        }
        let name:String = user.profile.givenName;
        let lastName:String = user.profile.familyName;
        let email:String = user.profile.email;
        let userId:String = user.userID;
        let url:URL = URL(string: Constants.FB_LOGIN)! ;
        let viewController = self.window?.rootViewController as! LoginVC
        let parameters = [ "first_name": name, "last_name":lastName,"email":email,"id":userId ] as [String : Any];
        
        RemoteRequest.jsonByRequestPost(requestUrl: url, parameters: parameters as [String : Any], completeHandler: { [self] (response) in
            if(response?["result"]["success"].bool ?? false){
                viewController.doLogin(response: response!);
            }
            }, errorHandler: nil, loadingMessage: "Cargando..", view: viewController.view, showDialogs: true)
                
    }
    
   
    func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? ) -> Bool {
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions );
        
        IQKeyboardManager.shared.enable = true
        GIDSignIn.sharedInstance().clientID = "615023104833-i9b0tvf04gangnbqdj80s8tg9ecjcha9.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self  // If AppDelegate conforms to GIDSignInDelegate
//        let token:String = Utils.getData(key: "access_token") as? String ?? ""
//        if(token != ""){
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let initialViewController = storyboard.instantiateViewController(withIdentifier: "HomeVC")
//            initialViewController.modalPresentationStyle = .fullScreen
//            self.window?.rootViewController = initialViewController
//            self.window?.makeKeyAndVisible()
//            
//        }
        return true
    };
    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool { ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
        
        return true;
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

