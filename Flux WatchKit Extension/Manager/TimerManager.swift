//
//  TimerManager.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 14/4/22.
//

import Foundation

class TimerManager: ObservableObject {
    
    static let shared = TimerManager()
    
    @Published var secondsElapsed: Int = 0
    var timer: Timer = Timer()
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.secondsElapsed -= 1
        }
    }
    
    func stop() {
        timer.invalidate()
        secondsElapsed = 0
    }
    
    func pause() {
        timer.invalidate()
    }
}

