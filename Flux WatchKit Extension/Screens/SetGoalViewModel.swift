//
//  SetGoalViewModel.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 21/6/22.
//

import Foundation

//
//class SetGoalViewModel: ObservableObject {
//
//    @Published var currenMinutesSetGoal = 0
//
//    func addMinutes() {
//        if self.data.last?.dailyGoal ?? 0 < 990 {
//            currenMinutes += 5
////            self.data.last?.dailyGoal += 5
//        }
//    }
//
//    func substractMinutes() {
//        if self.data.last?.dailyGoal ?? 0 > 0 {
//            currenMinutes -= 5
//         }
//    }
//
//    func dismissScreen() {
//        self.mode.wrappedValue.dismiss()
//    }
//
//    func saveGoalTime() {
//        // TO DO:  Review if you save is correct
//        let fxTime = FxTime(context: context)
//        fxTime.dailyGoal = currenMinutes
//        fxTime.dateAdded = Date()
//        PersistenceController.shared.save()
//    }
//
//}
