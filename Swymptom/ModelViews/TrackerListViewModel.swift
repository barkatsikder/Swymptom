//
//  TrackerListViewModel.swift
//  Swymptom
//
//  Created by Barkat Sikder on 8/22/20.
//  Copyright © 2020 Barkat Sikder. All rights reserved.
//

import Foundation
import Combine
import Resolver

class TrackerListViewModel: ObservableObject {
    
    //tbh don't know what this does
    @Published var trackerRepository: TrackerRepository = Resolver.resolve()
    //array of cells
    @Published var trackerCellViewModels = [TrackerCellViewModel]()

    private var cancellables = Set<AnyCancellable>()

    //probably turns all the cells into a list
    init() {
        trackerRepository.$trackers.map { trackers in
            trackers.map { tracker in
                TrackerCellViewModel(tracker: tracker)
            }
        }
        .assign(to: \.trackerCellViewModels, on: self)
        .store(in: &cancellables)
    }

    // I'm not giving any delete functionalities so...
//    func removeTrackers(atOffsets indexSet: IndexSet) {
//        // remove from repo
//        let viewModels = indexSet.lazy.map { self.trackerCellViewModels[$0] }
//        viewModels.forEach { trackerCellViewModel in
//            trackerRepository.removeTracker(trackerCellViewModel.tracker)
//        }
//    }

    func addTracker(tracker: Tracker) {
        trackerRepository.addTracker(tracker)
    }
}
