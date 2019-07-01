//
//  SettingsInterfaceController.swift
//  MeditationHelper WatchKit Extension
//
//  Created by Colton Lemmon on 6/30/19.
//  Copyright © 2019 Colton. All rights reserved.
//

import WatchKit
import Foundation


class SettingsInterfaceController: WKInterfaceController {

    @IBOutlet weak var intervalPicker: WKInterfacePicker!
    @IBOutlet weak var hideSwitch: WKInterfaceSwitch!
    @IBAction func hideChanged(_ value: Bool) {
        hide = value
    }
    @IBAction func intervalSelected(_ value: Int) {
        selectedIndex = value
    }
    @IBAction func saveButtonTapped() {
        if selectedIndex >= 0 && selectedIndex < pickerData.count {
            // Save interval associated with selected index I guess
            UserDefaults.standard.set(selectedIndex, forKey: Keys.DefaultsIntervalKey)
        }
        UserDefaults.standard.set(hide, forKey: Keys.DefaultsHideKey)
        self.pop()
    }
    
    private var selectedIndex = -1
    private var pickerData = [WKPickerItem]()
    private var hide: Bool = false
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setupData()
        intervalPicker.setItems(pickerData)
        setupDefaults()
    }
    
    private func setupData() {
        let quarter = WKPickerItem()
        quarter.title = "1/4"
        let third = WKPickerItem()
        third.title = "1/3"
        let half = WKPickerItem()
        half.title = "1/2"
        pickerData = [quarter, third, half]
    }
    
    private func setupDefaults() {
        hide = UserDefaults.standard.bool(forKey: Keys.DefaultsHideKey)
        hideSwitch.setOn(hide)
        
        selectedIndex = UserDefaults.standard.integer(forKey: Keys.DefaultsIntervalKey)
        intervalPicker.setSelectedItemIndex(selectedIndex)
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
