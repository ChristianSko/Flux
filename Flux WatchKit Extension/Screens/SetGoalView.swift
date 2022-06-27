//
//  SetGoalView.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 10/4/22.
//

import SwiftUI
import CoreData

struct SetGoalView: View {
    

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
//    @FetchRequest(
//        entity: FxTime.entity(),
//        sortDescriptors: [
//            NSSortDescriptor(keyPath: \FxTime.dateAdded, ascending: true)
//        ]
//    ) var data: FetchedResults<FxTime>

    @StateObject var vmData = CoreDataViewModel()
    @Environment(\.managedObjectContext) var context
    @State var currenMinutes: Double = 0
    
    var body: some View {
        VStack(spacing: 12){
            
            fxlabel(text: "DAILY FOCUS GOAL",
                    fontweight: .light,
                    type: .headline)
            .padding(.top, 10.0)
            
            VStack{
                HStack {
                    Button(action: {substractMinutes()}, label:  {
                        ChangGoalTimeButton(imageName: SFSymbols.minus)
                    })

                    Text("\(Int(currenMinutes))")
                        .font(.system(size: 45, design: .rounded))
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .frame(width: 85)
                        .focusable(true)
                        .digitalCrownRotation($currenMinutes,
                                              from: 0,
                                              through: 990,
                                              by: 5,
                                              sensitivity: .low,
                                              isContinuous: true,
                                              isHapticFeedbackEnabled: true)
                    
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
        .onAppear{
            currenMinutes = vmData.fxTime.last?.dailyGoal ?? 0
        }
    }
    
    
    func addMinutes() {
        if vmData.fxTime.last?.dailyGoal ?? 0 < 990 {
            currenMinutes += 5
//            self.data.last?.dailyGoal += 5
        }
    }
    
    func substractMinutes() {
        if vmData.fxTime.last?.dailyGoal ?? 0 > 0 {
//            self.data.last?.dailyGoal -= 5
            currenMinutes -= 5
         }
    }
    
    func dismissScreen() {
        self.mode.wrappedValue.dismiss()
    }
    
    func saveGoalTime() {
        
        
// TO DO:  Review if you save is correct
        
        let fxTime = FxTime(context: context)
        fxTime.dailyGoal = currenMinutes
        fxTime.dateAdded = Date()
        
        
        PersistenceController.shared.save()
    }
}

//struct SetGoalView_Previews: PreviewProvider {
//    static var previews: some View {
//        SetGoalView()
//    }
//}
