//
//  Stopwatch.swift
//  MeditationHelper WatchKit Extension
//
//  Created by Colton Lemmon on 8/20/18.
//  Copyright © 2018 Colton. All rights reserved.
//

import Foundation

protocol StopwatchDelegate {
    func currentStopwatchTime(elapsedTime: String)
}

class Stopwatch {
    
    // MARK: - Class Properties
    
    private var timer: Timer?
    private var pausedElapsedTime: TimeInterval?
    private var startTime: Date?
    
    var countDownTime: TimeInterval?
    var delegate: StopwatchDelegate?
    
    // MARK: - Computed Properties
    var elapsedTime: TimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    
    var elapsedTimeString: String {
        if let countDownTime = self.countDownTime {
            let timeLeft = countDownTime - self.elapsedTime
            if !(timeLeft < 0) {
                let minutesLeft = Int(timeLeft) / 60
                let secondsLeft = Int(timeLeft) % 60
//                let ms = Int((timeLeft * 10).truncatingRemainder(dividingBy: 10))
                return String(format: "%02i:%02i", minutesLeft, secondsLeft)
            } else {
                self.stop()
                return "00:00"
            }
        }
        return "00:00"
    }
    
    var isRunning: Bool {
        return self.startTime != nil
    }
    
    
    // MARK: - Methods
    func start() {
        self.startTime = Date()
        if self.delegate != nil {
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.callDelegateMethod(_ :)), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func callDelegateMethod(_ timer: Timer) {
        self.delegate?.currentStopwatchTime(elapsedTime: self.elapsedTimeString) ?? timer.invalidate()
    }
    
    func stop() {
        self.startTime = nil
        self.timer?.invalidate()
    }
    
    func pause() {
        self.timer?.invalidate()
    }
    
    func reset() {
        self.startTime = nil
        self.timer?.invalidate()
        self.delegate?.currentStopwatchTime(elapsedTime: self.elapsedTimeString)
    }
    
}
