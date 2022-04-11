//
//  SessionButton.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 10/4/22.
//

import SwiftUI

struct SessionButton: View {
    var sessionCycles: Int
    var sessionTime: Int
    var timeType: String
    
    
    var body: some View {
        VStack {
            Group{
                Text("\(sessionCycles)x")
                    .fontWeight(.light)
                    .font(.footnote)
                    .padding(.bottom, -7.0)
                
                Text("\(sessionTime)")
                    .font(.system(size: 28, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.brandPrimary)
                    .frame(width: 85, height: 30, alignment: .center)
                
                
                Text(timeType)
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
                    .padding(.top, -13.0)
            }
        }
    
        .background(Color.black)
        .frame(width: 68, height: 68, alignment: .center)
        .cornerRadius(50)
        .overlay(Circle()
        .strokeBorder(style: StrokeStyle(lineWidth: 4,dash: [2])))
        .padding()
    }
}

struct SessionButton_Previews: PreviewProvider {
    static var previews: some View {
        SessionButton(sessionCycles: 1,
                      sessionTime: 25,
                      timeType: "Min")
    }
}
