//
//  RingView.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 12/4/22.
//

import SwiftUI
import CoreData

struct RingView: View {
    
    @FetchRequest(
        entity: FxTime.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \FxTime.dateAdded, ascending: true)
        ]
    ) var data: FetchedResults<FxTime>

    
    var body: some View {
        ZStack {
            Ring(ringWidth: 15,
                 percent: (data.last?.focusedToday ?? 0 / (data.last?.dailyGoal ?? 0) ),
                 backgroundColor: Color.brandPrimary,
                 foregroundColors: [.white, Color.brandPrimary])
            
            RingInfoView(focusedToday: data.last?.focusedToday ?? 0,
                         dailyGoal: data.last?.dailyGoal ?? 0)
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }
}
