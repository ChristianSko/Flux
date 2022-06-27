//
//  SessionView.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 10/4/22.
//

import SwiftUI

struct SessionView: View {
    
    @State var showDefaultTimer = false
    @State var showSetGoalView = false
    @State var showWeeklySummary = false
    @State var showPersonalizeTimer = false
    @State var defaultTimer = false
    
    var sessionsCycles = [1,2,4]
    let sessionLengthMinutes = [25, 45]
    let seconds = 60
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack {
                    HStack{
                        ForEach(0..<2) {sessions in
                            VStack{
                                ForEach(0..<3) { number in
                                    NavigationLink {
                                        TimerView(totalCyles: sessionsCycles[number],
                                                  session: sessionLengthMinutes[sessions] * 60,
                                                  sucessFullSessionTime: sessionLengthMinutes[sessions])
                                    } label: {
                                         SessionButton(sessionCycles: sessionsCycles[number],
                                                      sessionTime: sessionLengthMinutes[sessions],
                                                      timeType: fxText.sessionMinutes)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                    
                    VStack{
                        
                        
                        SessionPersonalizeButton(text: fxText.personalizeButton,
                                                 symbol: SFSymbols.hourglass,
                                                 action: $showPersonalizeTimer)
                        .sheet(isPresented: $showPersonalizeTimer) { PersonalizeSessionView()}
                        
                        SessionActionButton(text: fxText.changeGoalButton,
                                            symbol: SFSymbols.downUpArrows,
                                            action: $showSetGoalView)
                        .sheet(isPresented: $showSetGoalView) { SetGoalView()}
                        
                        SessionActionButton(text:  fxText.weeklySummaryButton,
                                            symbol: SFSymbols.weeklyCalendar,
                                            action: $showWeeklySummary)
                        .sheet(isPresented: $showWeeklySummary) { WeeklySummaryView()}
                    }
                }
            }
        }
        
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SessionView()
        }
    }
}
