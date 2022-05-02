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
    
    @State var currentCycle = 1
    @State var totalCyles: Int
    @State var session: Int
    @State var sucessFullSessionTime: Int
    @State private var notificationDate: Date = Date()
    
    var body: some View {
        VStack{
            Spacer()
        
            fxlabel(text: "Session \(currentCycle) out of \(totalCyles)",
                    fontweight: .regular,
                    type: .body)
            
            
            Text("\(timeToString2(time: TimeInterval(TimerManager.shared.secondsElapsed)))")
                .font(Font.monospacedDigit(.system(size: 50))())
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
            
            Spacer()
            
            Button(action: {
                self.session = 0
                self.mode.wrappedValue.dismiss()
                TimerManager.shared.timer.invalidate()
                
            }) {
                ButtonTextStyle(title: "Stop")
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: requestPermission)
        .onAppear(perform: {
            TimerManager.shared.secondsElapsed = session
            TimerManager.shared.start()
        })
        .onAppear(){
            NotifyWhenFinished(timeInterval: session)
            if true {
                print("Timer reached 0, Add time to ring")
                let fxTime = FxTime(context: context)
                fxTime.focusedToday = Double(sucessFullSessionTime)
                fxTime.dateAdded = Date()
                fxTime.dailyGoal = data.last?.dailyGoal ?? 0
                PersistenceController.shared.save()
                self.mode.wrappedValue.dismiss()
            }
        }
        .onReceive(NotificationCenter.default.publisher(
            for: WKExtension.applicationWillResignActiveNotification
        )) { _ in
            movingToBackground()
        }
        .onReceive(NotificationCenter.default.publisher(
            for: WKExtension.applicationDidBecomeActiveNotification
        )) { _ in
            movingToForeground()
        }
    }
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func movingToBackground() {
        print("Moving to the background")
        notificationDate = Date()
        TimerManager.shared.pause()
    }
    
    func movingToForeground() {
        print("Moving to the foreground")
        let deltaTime: Int = Int(Date().timeIntervalSince(notificationDate))
        TimerManager.shared.secondsElapsed -= deltaTime
        TimerManager.shared.start()
    }
}


func NotifyWhenFinished(timeInterval: Int){
    
    let content = UNMutableNotificationContent()
    content.title = "Focus Session Completed"
    content.subtitle = "Break time!"
    content.sound = UNNotificationSound.default
    
    // show this notification one seconds from now
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval), repeats: false)
    
    // choose a random identifier
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    // add the notification request
    UNUserNotificationCenter.current().add(request)
}


func timeToString(from timeInterval: TimeInterval) -> String {
    
    let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
    let minutes = Int(timeInterval.truncatingRemainder(dividingBy: 60 * 60) / 60)
    
    return String(format: "%.2d:%.2d", minutes, seconds)
    
}

func timeToString2(time: TimeInterval) -> String {
    
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format:"%02i:%02i",minutes, seconds)
    
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(totalCyles: 1, session: 20, sucessFullSessionTime: 25)
    }
}
