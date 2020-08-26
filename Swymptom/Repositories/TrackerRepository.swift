//
//  TrackerRepository.swift
//  Swymptom
//
//  Created by Barkat Sikder on 8/22/20.
//  Copyright © 2020 Barkat Sikder. All rights reserved.
//

import Foundation
import Disk

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseFunctions

import Combine
import Resolver

// array of all trackers of a user
class BaseTrackerRepository {

  @Published var trackers = [Tracker]()
}

// methods for the array
protocol TrackerRepository: BaseTrackerRepository {
  func addTracker(_ tracker: Tracker)
  func removeTracker(_ tracker: Tracker)
  func updateTracker(_ tracker: Tracker)
}


// just for testing...?
//class TestDataTrackerRepository: BaseTrackerRepository, TrackerRepository, ObservableObject {
//  override init() {
//    super.init()
//    self.Trackers = testDataTrackers
//  }
//
//  func addTracker(_ tracker: Tracker) {
//    trackers.append(tracker)
//  }
//
//  func removeTracker(_ tracker: Tracker) {
//    if let index = trackers.firstIndex(where: { $0.id == tracker.id }) {
//      trackers.remove(at: index)
//    }
//  }
//
//  func updateTracker(_ tracker: Tracker) {
//    if let index = self.trackers.firstIndex(where: { $0.id == tracker.id } ) {
//      self.trackers[index] = tracker
//    }
//  }
//}


// local data methods - for the disk - see cloud below...
class LocalTrackerRepository: BaseTrackerRepository, TrackerRepository, ObservableObject {
  override init() {
    super.init()
    loadData()
  }
  
  func addTracker(_ tracker: Tracker) {
    self.trackers.append(tracker)
    saveData()
  }
  
  func removeTracker(_ tracker: Tracker) {
    if let index = trackers.firstIndex(where: { $0.id == tracker.id }) {
      trackers.remove(at: index)
      saveData()
    }
  }
  
  func updateTracker(_ tracker: Tracker) {
    if let index = self.trackers.firstIndex(where: { $0.id == tracker.id } ) {
      self.trackers[index] = tracker
      saveData()
    }
  }
  
  private func loadData() {
    if let retrievedTrackers = try? Disk.retrieve("trackers.json", from: .documents, as: [Tracker].self) {
      self.trackers = retrievedTrackers
    }
  }
  
  private func saveData() {
    do {
      try Disk.save(self.trackers, to: .documents, as: "trackers.json")
    }
    catch let error as NSError {
      fatalError("""
        Domain: \(error.domain)
        Code: \(error.code)
        Description: \(error.localizedDescription)
        Failure Reason: \(error.localizedFailureReason ?? "")
        Suggestions: \(error.localizedRecoverySuggestion ?? "")
        """)
    }
  }
}



// methods for cloud
class FirestoreTrackerRepository: BaseTrackerRepository, TrackerRepository, ObservableObject {
  @Injected var db: Firestore
  @Injected var authenticationService: AuthenticationService
  @LazyInjected var functions: Functions

  var trackersPath: String = "trackers"
  var userId: String = "unknown"
  
  private var listenerRegistration: ListenerRegistration?
  private var cancellables = Set<AnyCancellable>()
  
  override init() {
    super.init()
    
    authenticationService.$user
      .compactMap { user in
        user?.uid
      }
      .assign(to: \.userId, on: self)
      .store(in: &cancellables)
    
    // (re)load data if user changes
    authenticationService.$user
      .receive(on: DispatchQueue.main)
      .sink { [weak self] user in
        self?.loadData()
      }
      .store(in: &cancellables)
  }
  
  private func loadData() {
    if listenerRegistration != nil {
      listenerRegistration?.remove()
    }
    listenerRegistration = db.collection(trackersPath)
      .whereField("userId", isEqualTo: self.userId)
      .order(by: "createdTime")
      .addSnapshotListener { (querySnapshot, error) in
        if let querySnapshot = querySnapshot {
          self.trackers = querySnapshot.documents.compactMap { document -> Tracker? in
            try? document.data(as: Tracker.self)
          }
        }
      }
  }
  
  func addTracker(_ tracker: Tracker) {
    do {
      var userTracker = tracker
      userTracker.userId = self.userId
      let _ = try db.collection(trackersPath).addDocument(from: userTracker)
    }
    catch {
      fatalError("Unable to encode tracker: \(error.localizedDescription).")
    }
  }
  
  func removeTracker(_ tracker: Tracker) {
    if let trackerID = tracker.id {
      db.collection(trackersPath).document(trackerID).delete { (error) in
        if let error = error {
          print("Unable to remove document: \(error.localizedDescription)")
        }
      }
    }
  }
  
  func updateTracker(_ tracker: Tracker) {
    if let trackerID = tracker.id {
      do {
        try db.collection(trackersPath).document(trackerID).setData(from: tracker)
      }
      catch {
        fatalError("Unable to encode tracker: \(error.localizedDescription).")
      }
    }
  }
  
  func migrateTrackers(fromUserId: String) {
    let data = ["previousUserId": fromUserId]
    functions.httpsCallable("migrateTrackers").call(data) { (result, error) in
      if let error = error as NSError? {
        print("Error: \(error.localizedDescription)")
      }
      print("Function result: \(result?.data ?? "(empty)")")
    }
  }
}
