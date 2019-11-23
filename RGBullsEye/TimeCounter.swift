//
//  TimeCounter.swift
//  RGBullsEye
//
//  Created by Nathan Gross on 11/22/19.
//  Copyright © 2019 Nathan Gross. All rights reserved.
//

import Foundation
import Combine

class TimeCounter: ObservableObject {
    var timer: Timer?
    @Published var counter = 0
    
    @objc func updateCounter() {
        counter += 1
    }
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func killTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}
