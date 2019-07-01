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
        primaryStopwatch.stop()
        primaryTimer.invalidate()
        secondaryTimer.invalidate()
    }
    @IBAction func pauseButtonTapped() {
        primaryStopwatch.pause()
        // TODO: Add capability to pause primary and secondary timers then resume.
    }
    
    // MARK: - Properties
    
    fileprivate let notificationKey = "notificationKey"
    
    private var time: TimeInterval = 0 {
        didSet {
            secondaryTime = time/setFraction
        }
    }
    private var secondaryTime: TimeInterval = 0
    private var setFraction: Double = 4
    private var isPlaying: Bool = false
    private var timeRemaining: TimeInterval?
    lazy var primaryStopwatch: Stopwatch = Stopwatch()
    lazy var secondaryStopwatch: Stopwatch = Stopwatch()
    lazy var primaryTimer: Timer = Timer()
    lazy var secondaryTimer: Timer = Timer()
    private let session = WKExtendedRuntimeSession()
    private var hidden: Bool = false {
        didSet {
            timerLabel.setHidden(hidden)
        }
    }
    private var interval: Interval = .quarter {
        didSet {
            setFraction = interval.fraction
        }
    }
    
    // MARK: - Lifecycle
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setupDefaults()
        if let context = context as? [String: Double], let time = context["time"] {
            self.time = time
        }

        
        session.delegate = self
        primaryStopwatch.delegate = self
        guard time > 0 else {return}
        timeWasSet()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func setupDefaults() {
        hidden = UserDefaults.standard.bool(forKey: Keys.DefaultsHideKey)
        interval = Interval(rawValue: UserDefaults.standard.integer(forKey: Keys.DefaultsIntervalKey)) ?? Interval.quarter
    }
    
    private func timeWasSet() {
        self.timeRemaining = time
        self.primaryStopwatch.countDownTime = time
        self.primaryStopwatch.start()
        self.isPlaying = true
        self.scheduleLocalNotification()
        setupTimer()
        setupSecondaryTimer()
    }
    
    private func setupTimer() {
        primaryTimer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(timerMethod), userInfo: nil, repeats: false)
    }
    
    @objc private func timerMethod() {
        WKInterfaceDevice.current().play(.stop)
        session.invalidate()
        primaryTimer.invalidate()
        secondaryTimer.invalidate()
    }
    
    private func setupSecondaryTimer() {
        secondaryTimer = Timer.scheduledTimer(timeInterval: secondaryTime, target: self, selector: #selector(secondaryTimerMethod), userInfo: nil, repeats: true)
    }
    
    @objc private func secondaryTimerMethod() {
        WKInterfaceDevice.current().play(.success)
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
        
        UNUserNotificationCenter.current().add(request) { [weak self] (error) in
            if let error = error {
                // Error handle here!
                print("Unable to add notification request: \(error.localizedDescription)")
            } else {
                self?.session.start()
            }
        }
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationKey])
        session.invalidate()
        primaryTimer.invalidate()
        secondaryTimer.invalidate()
    }
    
    // MARK: - StopwatchDelegate Method
    
    func currentStopwatchTime(elapsedTime: String) {
        self.timerLabel.setText(elapsedTime)
    }
    
}

// MARK: - ExtendedRuntimeSession Delegate

extension TimerInterfaceController: WKExtendedRuntimeSessionDelegate {
    func extendedRuntimeSession(_ extendedRuntimeSession: WKExtendedRuntimeSession, didInvalidateWith reason: WKExtendedRuntimeSessionInvalidationReason, error: Error?) {
        // Track when session ends
        // Handle errors here
        print("Session Ended")
    }
    
    func extendedRuntimeSessionDidStart(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        // Track when session starts
        print("Session started!")
    }
    
    func extendedRuntimeSessionWillExpire(_ extendedRuntimeSession: WKExtendedRuntimeSession) {
        // Finish and clean up any tasks before session ends.
        print("Session will end")
    }
    
    
}
