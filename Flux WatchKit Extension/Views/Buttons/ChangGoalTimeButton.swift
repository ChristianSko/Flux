//
//  changeAmountButtonView.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 10/4/22.
//

import SwiftUI

struct ChangGoalTimeButton: View {
    var imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .foregroundColor(.brandPrimary)
            .font(.system(size: 38))
            .font(Font.body.weight(.ultraLight))
            .padding()
            .background(Color.black)
    }
}


struct ChangGoalTimeButton_Previews: PreviewProvider {
    static var previews: some View {
        ChangGoalTimeButton(imageName: SFSymbols.plus)
    }
}
