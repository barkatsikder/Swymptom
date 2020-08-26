//
//  AppDelegate.swift
//  Swymptom
//
//  Created by Barkat Sikder on 8/22/20.
//  Copyright © 2020 Barkat Sikder. All rights reserved.
//

import UIKit
import Firebase
import Resolver
import FirebaseFunctions
import GoogleSignIn

// https://firebase.google.com/docs/auth/ios/google-signin#swift_5
// https://www.jerriepelser.com/blog/forcing-users-sign-in-gsuite-domain-account/

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        // Use Firebase library to configure APIs
        
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    //see googledelegate below
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
          // ...
          if let error = error {
            // ...
            print(error.localizedDescription)
            return
          }

          guard let authentication = user.authentication else { return }
          let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                            accessToken: authentication.accessToken)
           //...

            Auth.auth().signIn(with: credential) { (res, err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                print("user= " + (res?.user.email)!)

                //
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)

            }
    }

        func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
            // Perform any operations when the user disconnects from app here.
            // ...

        }
        
    
    
    
}
    
    
//class GoogleDelegate: NSObject, GIDSignInDelegate, ObservableObject {
//
//    //@Published var signedIn: Bool = false
//
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//      // ...
//      if let error = error {
//        // ...
//        print(error.localizedDescription)
//        return
//      }
//
//      guard let authentication = user.authentication else { return }
//      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                        accessToken: authentication.accessToken)
//      // ...
//
////        Auth.auth().signIn(with: credential) { (res, err) in
////            if err != nil {
////                print((err?.localizedDescription)!)
////                return
////            }
////            print("user= " + (res?.user.email)!)
////
////            //
////            //self.signedIn = true
//
//        
//    }
//
//    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
//        // Perform any operations when the user disconnects from app here.
//        // ...
//
//    }
//
//}
    
    

    
    
    
    
    
    
    
    
    // MARK: - UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    




