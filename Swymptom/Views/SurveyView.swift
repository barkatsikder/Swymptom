//
//  SurveyView.swift
//  Swymptom
//
//  Created by Barkat Sikder on 8/23/20.
//  Copyright © 2020 Barkat Sikder. All rights reserved.
//

import SwiftUI


struct SurveyView: View {

    var yesno = ["No Answer", "Yes", "No"] //comment this out later and use VM's
    @State private var anyanswer1 = 0
    @State private var anyanswer2 = 0
    @State private var anyanswer3 = ""
    let onComplete: (Int, Int, String) -> Void
    

    var body: some View {
        NavigationView {
            //Text("placeholder")
            Form {
                //maybe tweek algorithm below later after i get more details
                //Q1
                Section(header: Text("Question 1: Have you contacted someone with COVID?")) {
                    Picker(selection: $anyanswer1, label: Text("Have you contacted someone with COVID or been outside of the country in 2 weeks?")) {
                        ForEach(0 ..< yesno.count) {
                            Text(self.yesno[$0])
                        }
                    }
                }
                if anyanswer1 != 0 {
                    if anyanswer1 == 1 {
                        Text("BIG RED LETTERS WARNING YOU 1")
                        Section(header: Text("Question 2: Do you have any of the following symptoms?")) {
                            Text("BIG RED LETTERS WARNING YOU 2")
                            Picker(selection: $anyanswer2, label: Text("Favorite Framework")) {
                                ForEach(0 ..< yesno.count) {
                                    Text(self.yesno[$0])
                                }
                            }
                        }
                    }
                     if anyanswer1 == 2 {
                        Section(header: Text("Question 2: Do you have any of the following symptoms?")) {
                            Picker(selection: $anyanswer2, label: Text("Favorite Framework")) {
                                ForEach(0 ..< yesno.count) {
                                    Text(self.yesno[$0])
                                }
                            }
                        }
                    }
                }
                //Q3
                if anyanswer2 != 0 {
                    if anyanswer2 == 1 {
                        Section(header: Text("Question 3: Write the symptoms.")) {
                            //Text("BIG RED LETTERS WARNING YOU ???")
                            TextField("Enter Symptoms", text: $anyanswer3)
                        }
                    }
                    if anyanswer2 == 2 {
                        // DONE...
                        Text("done...")
                    }
                }
                Section {
                    // if all questions answered, take to review page... ok maybe deal with review page later
                    Button(action: submitSurvey) {
                            Text("Review (actually submitting rn)")
                    }
                }
                
            } .navigationBarTitle(Text("Tracker Survey"), displayMode: .inline) //form
        }
        

    }
    
    private func submitSurvey() {
        onComplete(anyanswer1, anyanswer2, anyanswer3)
    }

        
}
