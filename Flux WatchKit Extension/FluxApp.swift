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
    @State var selectedTab = 1
    
    let persistenceController = PersistenceController.shared
    
    @SceneBuilder var body: some Scene {
        
        WindowGroup {
            TabView(selection: $selectedTab){
                    SessionView()
                        .tag(1)
                    RingView()
                        .tag(2)
                }
                .environmentObject(pomodoroModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: phase) { newValue in
            if pomodoroModel.isStarted{
                if newValue == .background || newValue == .inactive{
                    print("Inactive or baground")
                    lastActiveTimeStamp = Date()
                }
                
                if newValue == .active{
                    print("Active")
                    // MARK: Finding The Difference
                    let currentTimeStampDiff = Date().timeIntervalSince(lastActiveTimeStamp)
                    if pomodoroModel.totalSeconds - Int(currentTimeStampDiff) <= 0{
                        pomodoroModel.isStarted = false
                        pomodoroModel.totalSeconds = 0
                        pomodoroModel.updateTimer()
                    }else{
                        pomodoroModel.totalSeconds -= Int(currentTimeStampDiff)
                        print("Else")
                    }
                }
            }
        }
        .onChange(of: selectedTab) { tabTag in
            if pomodoroModel.isStarted{
                if tabTag == 2{
                    print("On th Tap during timer")
                    lastActiveTimeStamp = Date()
                }
                
                if tabTag == 1{
                    print("On the Timer")
                    // MARK: Finding The Difference
                    let currentTimeStampDiff = Date().timeIntervalSince(lastActiveTimeStamp)
                    if pomodoroModel.totalSeconds - Int(currentTimeStampDiff) <= 0{
                        pomodoroModel.isStarted = false
                        pomodoroModel.totalSeconds = 0
                        pomodoroModel.updateTimer()
                    }else{
                        pomodoroModel.totalSeconds -= Int(currentTimeStampDiff)
                        print("Else")
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
