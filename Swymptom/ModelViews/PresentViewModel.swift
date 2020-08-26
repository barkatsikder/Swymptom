//
//  PresentViewModel.swift
//  Swymptom
//
//  Created by Barkat Sikder on 8/25/20.
//  Copyright © 2020 Barkat Sikder. All rights reserved.
//

import Foundation
import Combine
import Resolver

import UserNotifications


// i can do all status and notifications related shit here

//class PresentStatus: ObservableObject {
//
//
//    //according to present status algorithm...
//    static func scheduleNotifications() -> Void {
//          UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                    if success {
//                        print("Success")
//                      //To add badgeNumber
//                      //UIApplication.shared.applicationIconBadgeNumber = badgeNumber //(Integer Value)
//
//                    } else if let error = error {
//                        print(error.localizedDescription)
//                    }
//            }
//
//
//            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//            let content = UNMutableNotificationContent()
//            content.title = "Swymptom at noon"
//            content.body = "Daily Notification is Ready"
//            content.sound = UNNotificationSound.default
//
//            //how tf is this 2pm local every day??? must be wrong.
//            var dateComponents = DateComponents()
//            dateComponents.hour = 10
//            dateComponents.minute = 01
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//            //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//            UNUserNotificationCenter.current().add(request)
//    }
//
//
//}

//
//@objc func registerLocal() {
//    let center = UNUserNotificationCenter.current()
//
//    center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
//        if granted {
//            print("Yay!")
//        } else {
//            print("D'oh")
//        }
//    }
//}
//
//@objc func scheduleLocal() {
//    let center = UNUserNotificationCenter.current()
//
//    let content = UNMutableNotificationContent()
//    content.title = "Late wake up call"
//    content.body = "The early bird catches the worm, but the second mouse gets the cheese."
//    content.categoryIdentifier = "alarm"
//    content.userInfo = ["customData": "fizzbuzz"]
//    content.sound = UNNotificationSound.default
//
//    var dateComponents = DateComponents()
//    dateComponents.hour = 10
//    dateComponents.minute = 30
//    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//    center.add(request)
//}
