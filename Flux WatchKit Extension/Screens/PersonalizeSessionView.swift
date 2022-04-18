//
//  PersonalizeSessionView.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 14/4/22.
//

import SwiftUI

struct PersonalizeSessionView: View {
    
    @State var startTimerView = false
    @State var selectedCycle: Int = 1
    @State var selectedMinutesAmount: Int = 1
    
    let cycleInt: [Int] = Array(1...12)
    let minsInt: [Int] = Array(1...60)
    let seconds = 60
    
    var body: some View {
        VStack {
            HStack {
                FxPicker(label: "Cycles", unit: cycleInt, selected: $selectedCycle)
                FxPicker(label: "Minutes", unit: minsInt, selected: $selectedMinutesAmount)
            }
            .padding()
        
            Button(action: {
                startTimerView.toggle()
            }, label: {
                ButtonTextStyle(title: "Start")
            })
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            .sheet(isPresented: $startTimerView, content: {
                TimerView(totalCyles: selectedCycle,
                          session: selectedMinutesAmount * seconds,
                          sucessFullSessionTime: selectedMinutesAmount)
            })
        }
    }
}


struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalizeSessionView(startTimerView: false,
                               selectedCycle: 1,
                               selectedMinutesAmount: 1)
    }
}
