//
//  FluxApp.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 10/4/22.
//

import SwiftUI

@main
struct FluxApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                SetGoalView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
