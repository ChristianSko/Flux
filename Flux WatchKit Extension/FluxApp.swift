//
//  FluxApp.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 10/4/22.
//

import SwiftUI

@main
struct FluxApp: App {
    
    @StateObject var pomodoroModel: FxTimerViewModel = .init()
    @Environment(\.scenePhase) var phase
    @State var lastActiveTimeStamp: Date = Date()
    
    let persistenceController = PersistenceController.shared
    
    @SceneBuilder var body: some Scene {
        
        WindowGroup {
                TabView{
                    SessionView()
                    RingView()
                }
                .environmentObject(pomodoroModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: phase) { newValue in
            if pomodoroModel.isStarted{
                if newValue == .background{
                    lastActiveTimeStamp = Date()
                }
                
                if newValue == .active{
                    // MARK: Finding The Difference
                    let currentTimeStampDiff = Date().timeIntervalSince(lastActiveTimeStamp)
                    if pomodoroModel.totalSeconds - Int(currentTimeStampDiff) <= 0{
                        pomodoroModel.isStarted = false
                        pomodoroModel.totalSeconds = 0
                        pomodoroModel.updateTimer()
                    }else{
                        pomodoroModel.totalSeconds -= Int(currentTimeStampDiff)
                    }
                }
            }
        }
        
//        .onChange(of: phase) { _ in
//            persistenceController.save()
//        }
        
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
