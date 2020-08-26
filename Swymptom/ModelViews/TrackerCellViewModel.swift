//
//  TrackerCellViewModel.swift
//  Swymptom
//
//  Created by Barkat Sikder on 8/22/20.
//  Copyright © 2020 Barkat Sikder. All rights reserved.
//

import Foundation
import Combine
import Resolver

class TrackerCellViewModel: ObservableObject, Identifiable  {
    
    @Injected var trackerRepository: TrackerRepository
    @Published var tracker: Tracker
    
    var id: String = ""
    private var cancellables = Set<AnyCancellable>()

    // maybe this should go in track model? or maybe its fine here in view model
    static func newTracker(a1:Int?, a2:Int?, a3:String?) -> Tracker {
        //algorithm can probably go here
        
        //hardcoded for now
        let status:TrackerStatus = .Negative
        let answer1 = false
        let answer2 = false
        let answer3 = "hard coded no symptom?"
        
        // i dont want to return to view. i wanna return to wherever im adding this to database
        return Tracker(status: status, answer1: answer1, answer2: answer2, answer3: answer3)
    }

    
    //createdTime
    //status,   answer1, answer2, answer3,
    // configure information that's gonna be viewed and stored
    init(tracker: Tracker) {
        self.tracker = tracker
        
        $tracker
        .compactMap { $0.id }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
         


    }

  
}


class PresentStatusViewModel: ObservableObject, Identifiable  {
    
    
}
