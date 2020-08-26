//
//  ReviewSurveyMVVM.swift
//  Swymptom
//
//  Created by Barkat Sikder on 8/22/20.
//  Copyright © 2020 Barkat Sikder. All rights reserved.
//

// MARK: - for review page and also hold temporary notification info since review is less important and can come later

//import SwiftUI
//import UserNotifications 
//
//struct NotificationCreator {
//    
//    func scheduleNotifications() {
//          UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                    if success {
//                        print("Success")
//                      //To add badgeNumber
//                      //UIApplication.shared.applicationIconBadgeNumber = badgeNumber (Integer Value)
//                      
//                    } else if let error = error {
//                        print(error.localizedDescription)
//                    }
//            }
//            
//            
//            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//            let content = UNMutableNotificationContent()
//            content.title = "Daily Notification"
//            content.body = "Daily Notification is Ready"
//            content.sound = UNNotificationSound.default
//
//            var dateComponents = DateComponents()
//            dateComponents.hour = 11
//            dateComponents.minute = 59
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//    //        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//            UNUserNotificationCenter.current().add(request)
//    }
//    
//    
//}
