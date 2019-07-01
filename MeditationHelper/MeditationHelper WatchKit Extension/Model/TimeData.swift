//
//  TimeData.swift
//  MeditationHelper WatchKit Extension
//
//  Created by Colton Lemmon on 6/30/19.
//  Copyright © 2019 Colton. All rights reserved.
//

import Foundation

struct TimeData {
    static private(set) var data: [Time] = [
    Time(title: "1 MIN", value: 60),
    Time(title: "2 MIN", value: 120),
    Time(title: "3 MIN", value: 180),
    Time(title: "5 MIN", value: 300),
    Time(title: "10 MIN", value: 600),
    Time(title: "15 MIN", value: 900),
    Time(title: "20 MIN", value: 1200),
    Time(title: "30 MIN", value: 1800),
    Time(title: "45 Min", value: 2700),
    Time(title: "1 HR", value: 3600)
    ]
}
