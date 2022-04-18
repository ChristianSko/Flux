//
//  RingInfoView.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 18/4/22.
//

import SwiftUI

struct RingInfoView: View {
    
    let focusedToday: Double
    let dailyGoal: Double
    
    var body: some View {
        VStack{
            Text("\(focusedToday / dailyGoal, specifier: "%.2f") %")
                .font(.system(.body,design: .rounded))
                .fontWeight(.light)
            
            fxlabel(text: "Focused Today",
                    fontweight: .bold,
                    type: .body)
            
            Text("\(Int(focusedToday)) of \(Int(dailyGoal)) Min")
                .fontWeight(.light)
        }
        .padding()
    }
}

struct RingInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RingInfoView(focusedToday: 10,
                     dailyGoal: 120)
    }
}
