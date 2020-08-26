//
//  SettingsView.swift
//  Swymptom
//
//  Created by Barkat Sikder on 8/22/20.
//  Copyright © 2020 Barkat Sikder. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
  @ObservedObject var settingsViewModel = SettingsViewModel()
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  var body: some View {
    NavigationView {
        // lots of random shit goes here but i'll come back to it later and copy paste/tweak
        VStack {
          Image("Logo")
            .resizable()
            .frame(width: 100, height: 100)
            .aspectRatio(contentMode: .fit)
            .padding(.horizontal, 100)
            .padding(.top, 20)

          Text("Thanks for using")
            .font(.title)

          Text("Make It So")
            .font(.title)
            .fontWeight(.semibold)
          
          Form {
            Section {
              HStack {
                Image(systemName: "checkmark.circle")
                Text("App Icon")
                Spacer()
                Text("Plain")
              }
            }
            
            Section {
              HStack {
                Image("Siri")
                  .resizable()
                  .frame(width: 17, height: 17)
                Text("Siri")
              }
            }
            
            Section {
              HStack {
                Image(systemName: "questionmark.circle")
                Text("Help & Feedback")
              }
              NavigationLink(destination: Text("About!") ) {
                HStack {
                  Image(systemName: "info.circle")
                  Text("About")
                }
              }
            }
            
          //meat down here
          AccountSection(settingsViewModel: self.settingsViewModel)
        }
        .navigationBarTitle("Settings", displayMode: .inline)
        .navigationBarItems(trailing:
          Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Text("Done")
        })
    }
}
}
}



struct AccountSection: View {
  @ObservedObject var settingsViewModel: SettingsViewModel
  @State private var showSignInView = false
  
  var body: some View {
    Section(footer: footer) {
      button
    }
  }
  
  var footer: some View {
    HStack {
      Spacer()
        VStack {
          Text("Thanks for using Make It So, \(self.settingsViewModel.displayName)!")
          Text("Logged in as \(self.settingsViewModel.email)")
        }
      Spacer()
    }
  }
  
  var button: some View {
    VStack {
        Button(action: { self.logout() }) {
          HStack {
            Spacer()
            Text("Logout")
            Spacer()
          }
        }
    }
  }
  
//  func login() {
//    self.showSignInView.toggle()
//  }
  
  func logout() {
    self.settingsViewModel.logout()
    //TrackerListView.showSettingsScreen.toggle()
  }
  
}

