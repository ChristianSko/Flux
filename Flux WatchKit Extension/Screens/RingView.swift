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
        VStack{
            //            Text("\(achievedTime/objectiveTime)%")
            Text("\(data.last?.focusedToday ?? 0 / (data.last?.dailyGoal ?? 0), specifier: "%.2f") %")
                .font(.system(.body,design: .rounded))
                .fontWeight(.light)
            
            fxlabel(text: "Focused Today",
                    fontweight: .bold,
                    type: .body)
    
            Text("0 of \(Int(data.last?.dailyGoal ?? 0)) Min")
                .fontWeight(.light)
        }
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView()
    }
}


//struct FocusedTime: View {
//    @ObservedObject var data: FxTime
//
//    var body: some View {
//        HStack {
//            Text("\(data.dailyGoal)")
//        }
//    }
//}
