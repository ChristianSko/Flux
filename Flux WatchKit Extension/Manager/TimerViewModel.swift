//
//  TimerManager.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 14/4/22.
//

import Foundation
struct TimerModel {
    var secondsElapsed: Int = 0
}

class TimerViewModel: ObservableObject {
    
    static let shared = TimerViewModel()
    @Published var timerModel = TimerModel()
    
    var timer: Timer = Timer()
    var secondsElapsed: Int {
        return self.timerModel.secondsElapsed
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            DispatchQueue.main.async {
                self.timerModel.secondsElapsed -= 1
            }
        }
    }
    
    func stop() {
        timer.invalidate()
        self.timerModel.secondsElapsed = 0
    }
    
    func pause() {
        timer.invalidate()
    }
}

