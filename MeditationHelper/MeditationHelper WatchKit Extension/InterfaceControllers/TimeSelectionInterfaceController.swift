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
    
    @IBOutlet var twoMinButtonTapped: WKInterfaceButton!
    
    @IBAction func minButtonTapped() {
        let context: [String: Double] = ["time":60]
        self.pushController(withName: "TimerInterfaceController", context: context)
        
    }
    
    // MARK: - Lifecycle
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
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
