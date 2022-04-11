//
//  SessionPersonalizeButton.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 11/4/22.
//

import SwiftUI

struct SessionPersonalizeButton: View {
    let text: String
    let symbol: String
    @Binding var action: Bool
    
    var body: some View {
        Button {
            self.action.toggle()
        } label: {
            Label(text, systemImage: symbol)
        }
        .buttonStyle(.borderedProminent)
        .tint(.brandPrimary)
    }
}

struct SessionPersonalizeButton_Previews: PreviewProvider {
    static var previews: some View {
        SessionPersonalizeButton(text: "Personalize", symbol: SFSymbols.hourglass, action: .constant(false))
    }
}
