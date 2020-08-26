//
//  Tracker.swift
//  Swymptom
//
//  Created by Barkat Sikder on 8/22/20.
//  Copyright © 2020 Barkat Sikder. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift




enum TrackerStatus: String, Codable {
    case Positive = "Positive"
    case Negative = "Negative"
    case Pending = "Pending"
    case DocumentedExposure = "DocumentedExposure"
    case Antibodies = "Antibodies"
    case Expired = "Expired"
    case NoData = "NoData"
}

struct Tracker: Codable, Identifiable {
    
    var userId: String? //
    @DocumentID var id: String? //
    @ServerTimestamp var createdTime: Timestamp? // is date and time? //
    
    var status: TrackerStatus
    
    var answer1: Bool?
    var answer2: Bool?
    var answer3: String?
}


