//
//  TrackerListView.swift
//  Swymptom
//
//  Created by Barkat Sikder on 8/22/20.
//  Copyright © 2020 Barkat Sikder. All rights reserved.
//

import SwiftUI

//for now until i move logout to settings
import Firebase
import GoogleSignIn


// List + homepage
struct TrackerListView: View {
    
    //get from list view model
    @ObservedObject var trackerListVM = TrackerListViewModel()
    
    //@State var presentAddNewItem = false
    @State var showSettingsScreen = false
    @State var showSurveyScreen = false
    
    
  
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading) {
                List {
                    //for each cell in the list i got, display cell data according to specified view
                    ForEach (trackerListVM.trackerCellViewModels, id: \.id) { trackerCellVM in
                        TrackerCell(trackerCellVM: trackerCellVM)
                    }
                 }
                    .sheet(isPresented: $showSurveyScreen) {
                      SurveyView() { a1, a2, a3 in
                          self.trackerListVM.addTracker(tracker: TrackerCellViewModel.newTracker(a1: a1, a2: a2, a3: a3))
                          self.showSurveyScreen.toggle()
                      }
                    }
//                // start: temp until settings
//                Button(action: {
//                    try! Auth.auth().signOut()
//                    GIDSignIn.sharedInstance()?.signOut()
//                    UserDefaults.standard.set(false, forKey: "status")
//                    NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
//
//                }) {
//
//                    Text("Logout")
//                }
//                // end: temp until settings

            }
            .navigationBarTitle("Trackers")
            
            .navigationBarItems(
                leading: HStack {
                Button(action: {
                    self.showSettingsScreen.toggle()
                }) {
                    Image(systemName: "gear")
                    }
                    .sheet(isPresented: $showSettingsScreen) {
                        SettingsView()
                        //self.showSettingsScreen.toggle()
                        
                    
                    }
                },

                trailing: HStack {
                Button(action: {
                    self.showSurveyScreen.toggle()
                    
                }) {
                    Image(systemName: "plus")
                    }
                }
            )


              
              
                
                
        }
    }
}



// purely for display, no interaction
struct TrackerCell: View {
    
    // instantiate cell
    @ObservedObject var trackerCellVM: TrackerCellViewModel
    //var onCommit: (Result<Tracker, InputError>) -> Void = { _ in }
    
    //let date = postTimestamp.dateValue()

    var body: some View {
        HStack {
            Text("Another tracker displayed")
            //trackerCellVM.tracker.createdTime.dateValue()
        }
    }
}
