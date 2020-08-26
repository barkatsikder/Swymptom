//
//  AuthenticationService.swift
//  Swymptom
//
//  Created by Barkat Sikder on 8/22/20.
//  Copyright © 2020 Barkat Sikder. All rights reserved.
//
//
//


import Foundation
import SwiftUI
import Firebase
import Resolver
import GoogleSignIn



class AuthenticationService: ObservableObject {

      @Published var user: User?
      @LazyInjected private var trackerRepository: TrackerRepository
      private var handle: AuthStateDidChangeListenerHandle?

    //@EnvironmentObject var googleDelegate: GoogleDelegate
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
          
        
    }

}



// MARK: -
struct ContentView: View {
    
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        
        VStack{
            
            if Auth.auth().currentUser != nil {
                TrackerListView()
            }
            else {
                SignInView()
            }
        }.animation(.spring())
        .onAppear {
                
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                self.status = status
            }
        }
    }
}







