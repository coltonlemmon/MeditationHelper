//
//  TimerInterfaceController.swift
//  MeditationHelper WatchKit Extension
//
//  Created by Colton Lemmon on 8/20/18.
//  Copyright © 2018 Colton. All rights reserved.
//

import UIKit
import WatchKit
import UserNotifications

class TimerInterfaceController: WKInterfaceController, StopwatchDelegate {
    
    //MARK: - Outlets and Actions
    
    @IBOutlet var timerLabel: WKInterfaceLabel!
    @IBOutlet var cancelButton: WKInterfaceButton!
    @IBOutlet var pauseButton: WKInterfaceButton!
    
    @IBAction func cancelButtonTapped() {
        
    }
    @IBAction func pauseButtonTapped() {
        
    }
    
    // MARK: - Properties
    
    fileprivate let notificationKey = "notificationKey"
    
    private var time: TimeInterval?
    private var isPlaying: Bool = false
    private var timeRemaining: TimeInterval?
    lazy var stopwatch: Stopwatch = Stopwatch()
    
    // MARK: - Lifecycle
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if let context = context as? [String: Double], let time = context["time"] {
            self.time = time
        }
        stopwatch.delegate = self
        if let time = self.time {
            self.timeRemaining = time
            self.stopwatch.countDownTime = time
            self.stopwatch.start()
            self.isPlaying = true
            self.scheduleLocalNotification()
        }
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //MARK: - Notification
    
    func scheduleLocalNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.sound = UNNotificationSound.default()
        notificationContent.title = "Timer finished"
        
        guard let timeRemaining = self.timeRemaining else { return }
        let fireDate = Date(timeInterval: timeRemaining, since: Date())
        let dateComponenets = Calendar.current.dateComponents([.minute, .second], from: fireDate)
        
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponenets, repeats: false)
        
        let request = UNNotificationRequest(identifier: notificationKey, content: notificationContent, trigger: dateTrigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                // Error handle here!
                print("Unable to add notification request: \(error.localizedDescription)")
            }
        }
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationKey])
    }
    
    // MARK: - StopwatchDelegate Method
    
    func currentStopwatchTime(elapsedTime: String) {
        self.timerLabel.setText(elapsedTime)
    }
    
}
