//
//  SetGoalView.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 10/4/22.
//

import SwiftUI

struct SetGoalView: View {
    
    @State var goalTime = 0
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 25){

            Text("DAILY FOCUS GOAL")
                .font(.system(size: 16, design: .rounded))
                .fontWeight(.light)
                .foregroundColor(Color.brandPrimary)
            
            VStack{
                HStack {
                    Button(action: {
                        if self.goalTime > 0 {
                            self.goalTime -= 5
                            print(goalTime)
                         }
                    }) {
                        changeAmountButtonView(imageName: SFSymbols.minus)
                    }
                    
                    Text("\(Int(goalTime))")
                        .font(.system(size: 45, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .frame(width: 85, height: 30, alignment: .center) // to review
                        
//                        .layoutPriority(1) //to review
//                        .focusable(true)
//                        .digitalCrownRotation($goalTime, from: 0, through: 990, by: 5, sensitivity: .medium, isContinuous: true, isHapticFeedbackEnabled: true)
                    
                    
                    
                    Button(action: {
                        if self.goalTime < 990 {
                           self.goalTime += 5
                            print(goalTime)
                        }
                    }) {
                        changeAmountButtonView(imageName: SFSymbols.plus)
                    }
                }
                
                fxlabel(text: "Minutes", fontweight: .semibold)
                    .padding(.top, -5.0)
            }
            
            Button(action: {
                UserDefaults.standard.set(self.goalTime, forKey: UserdefaultKeys.goal)
                self.mode.wrappedValue.dismiss()
                
            }) {
            ButtonTextStyle(title: "Update")
            }
            .background(Color.brandPrimary)
            .cornerRadius(50)
        }
    }
}

struct SetGoalView_Previews: PreviewProvider {
    static var previews: some View {
        SetGoalView()
    }
}

struct fxlabel: View {
    
    let text: String
    let fontweight: Font.Weight
    
    var body: some View {
    
        Text(text)
            .font(.system(.body, design: .rounded))
            .fontWeight(fontweight)
            .foregroundColor(Color.brandPrimary)
            .padding(.top, -5.0)
        
    }
}
