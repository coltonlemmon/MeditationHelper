//
//  TimeSelectionInterfaceController.swift
//  MeditationHelper WatchKit Extension
//
//  Created by Colton Lemmon on 8/20/18.
//  Copyright © 2018 Colton. All rights reserved.
//

import UIKit
import WatchKit

class TimeSelectionInterfaceController: WKInterfaceController {
    
    // MARK: - Outlets and Actions
    
    @IBOutlet var twoMinButton: WKInterfaceButton!
    @IBOutlet weak var oneMinuteButton: WKInterfaceButton!
    
    @IBAction func settingsButtonTapped() {
        self.pushController(withName: "SettingsInterfaceController", context: nil)
    }
    
    @IBAction func minButtonTapped() {
        let context: [String: Double] = ["time":60]
        
        self.pushController(withName: "TimerInterfaceController", context: context)
        
    }
    @IBAction func twoMinButtonTapped() {
        let context: [String: Double] = ["time":120]
        self.pushController(withName: "TimerInterfaceController", context: context)
    }
    
    // MARK: - Lifecycle
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        //self.addMenuItem(withImageNamed: "", title: "", action: ) I dunno if this works or not like a collection view
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
