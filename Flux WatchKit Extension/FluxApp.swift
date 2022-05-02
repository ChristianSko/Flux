//
//  FluxApp.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 10/4/22.
//

import SwiftUI

@main
struct FluxApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared
    
    @SceneBuilder var body: some Scene {
        
        WindowGroup {
            NavigationView {
                TabView{
                    SessionView()
                    RingView()
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
        
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
