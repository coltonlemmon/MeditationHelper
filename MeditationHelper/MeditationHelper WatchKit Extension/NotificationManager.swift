//
//  NotificationManager.swift
//  MeditationHelper WatchKit Extension
//
//  Created by Colton Lemmon on 8/20/18.
//  Copyright © 2018 Colton. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static func scheduleLocalNotification(for time: TimeInterval) {
        
        let modalAction = UNNotificationAction(identifier: Keys.NotificationActionKey, title: "Action Title", options: [.foreground])
        
        let primaryCategory = UNNotificationCategory(identifier: Keys.NotificationCategoryKey, actions: [modalAction], intentIdentifiers: [], options: [])
        
        let categories: Set<UNNotificationCategory> = [primaryCategory]
        
        UNUserNotificationCenter.current().setNotificationCategories(categories)
        
    }
}
