//
//  SetGoalView.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 10/4/22.
//

import SwiftUI
import CoreData

struct SetGoalView: View {
    
    @State var goalTime: Double = 0
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack(spacing: 20){
            
            fxlabel(text: "DAILY FOCUS GOAL",
                    fontweight: .light,
                    type: .headline)
            .padding(.top, 10.0)
            
            VStack{
                HStack {
                    Button(action: {substractMinutes()}, label:  {
                        ChangGoalTimeButton(imageName: SFSymbols.minus)
                    })

                    Text("\(Int(goalTime))")
                        .font(.system(size: 45, design: .rounded))
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .frame(width: 85)
                        .focusable(true)
                        .digitalCrownRotation($goalTime)
                    
                    Button(action: { addMinutes() }, label:  {
                        ChangGoalTimeButton(imageName: SFSymbols.plus)
                    })
                }
                
                fxlabel(text: "Minutes",
                        fontweight: .semibold,
                        type: .body)
                    .padding(.top, -10.0)
            }
            
            Button(action: {
                saveGoalTime()
                dismissScreen()
            }, label:  {
                ButtonTextStyle(title: "Update")
            })
            .buttonStyle(.borderedProminent)
            .tint(.blue)
        }
    }
    
    
    func addMinutes() {
        if self.goalTime < 990 {
            self.goalTime += 5
        }
    }
    
    func substractMinutes() {
        if self.goalTime > 0 {
            self.goalTime -= 5
         }
    }
    
    func dismissScreen() {
        self.mode.wrappedValue.dismiss()
    }
    
    func saveGoalTime() {
        let fxTime = FxTime(context: context)
        fxTime.dailyGoal = goalTime
        PersistenceController.shared.save()
    }
}

struct SetGoalView_Previews: PreviewProvider {
    static var previews: some View {
        SetGoalView()
    }
}