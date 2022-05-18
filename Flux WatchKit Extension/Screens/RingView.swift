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

    var sumFocusedToday: Double {
        data.reduce(0){ $0 + $1.focusedToday }
    }
    
    var percentage: Double {
        let finalvalue = sumFocusedToday / (data.last?.dailyGoal ?? 0)
        
        // NOTE: inifinity results cause ring to crash
        // TO DO: refactor
        
        if finalvalue != .infinity {
            return finalvalue * 100
        } else {
            return 0
        }
    }
    
    var body: some View {
        ZStack {
            Ring(ringWidth: 10,
                 percent: percentage ,
                 backgroundColor: Color.brandPrimary,
                 foregroundColors: [.white, Color.brandPrimary])
            

            
            RingInfoView(focusedToday: sumFocusedToday,
                         dailyGoal: data.last?.dailyGoal ?? 0)
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }
}
