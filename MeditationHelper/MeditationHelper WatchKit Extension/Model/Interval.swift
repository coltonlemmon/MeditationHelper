//
//  Interval.swift
//  MeditationHelper WatchKit Extension
//
//  Created by Colton Lemmon on 6/30/19.
//  Copyright © 2019 Colton. All rights reserved.
//

import Foundation

enum Interval: Int {
    case quarter = 0
    case third = 1
    case half = 2
    
    var display: String {
        switch self {
        case .quarter:
            return "1/4"
        case .third:
            return "1/3"
        case .half:
            return "1/2"
        }
    }
    
    var fraction: Double {
        switch self {
        case .quarter:
            return 4
        case .third:
            return 3
        case .half:
            return 2
        }
    }
}
