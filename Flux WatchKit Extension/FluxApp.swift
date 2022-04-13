//
//  FluxApp.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 10/4/22.
//

import SwiftUI

@main
struct FluxApp: App {
    
    
    @State private var currentTab = 0
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = PersistenceController.shared
    
    @SceneBuilder var body: some Scene {
        
        WindowGroup {
            
            NavigationView {
                
                TabView{
                    SessionView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    RingView()
                }
            }
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
        
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
