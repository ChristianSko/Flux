//
//  CoreDataViewModel.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 26/6/22.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer

    @Published var fxTime: [FxTime] = []

    init() {
        container = NSPersistentContainer(name: "FxTime")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            } else {
                print("Loaded persistent stores")
            }
            self.fetchEntity()
        }
    }

    func fetchEntity() {
        let request = NSFetchRequest<FxTime>(entityName: "FxTime")
        do {
            let fxTime = try container.viewContext.fetch(request)
            self.fxTime = fxTime
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }

    func addDailyGoalTime(time: Double) {
        let newTime = FxTime(context: container.viewContext)
        newTime.dailyGoal = time
        saveData()
    }

    func saveData() {
        do {
            try container.viewContext.save()
            fetchEntity()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}


