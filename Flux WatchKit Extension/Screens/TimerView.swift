//
//  TimerView.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 14/4/22.
//

import SwiftUI
import UserNotifications
import CoreData

struct TimerView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    @FetchRequest(
        entity: FxTime.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \FxTime.dateAdded, ascending: true)
        ]
    ) var data: FetchedResults<FxTime>
    
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var fxTimerViewModel: FxTimerViewModel
    
    @State var currentCycle = 1
    @State var totalCyles: Int
    @State var session: Int
    @State var sucessFullSessionTime: Int
    
    var body: some View {
        VStack{
            Spacer()
            
            fxlabel(text: "Session \(currentCycle) out of \(totalCyles)",
                    fontweight: .regular,
                    type: .body)
            
            Text(fxTimerViewModel.timerStringValue)
                .fontWeight(.heavy)
                .foregroundColor(Color.white)

            Spacer()
            
            Button(action: {
                fxTimerViewModel.stopTimer()
                self.mode.wrappedValue.dismiss()
                
            }) {
                ButtonTextStyle(title: "Stop")
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
        }
        .onAppear{
            fxTimerViewModel.seconds = session
            fxTimerViewModel.startTimer()
        }
        .navigationBarBackButtonHidden(true)
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if fxTimerViewModel.isStarted{
                fxTimerViewModel.updateTimer()
            }
        }
        .onAppear(perform: fxTimerViewModel.authorizeNotification)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(totalCyles: 1, session: 20, sucessFullSessionTime: 25)
    }
}
