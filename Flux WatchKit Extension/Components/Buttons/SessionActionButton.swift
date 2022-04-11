//
//  SessionActionButton.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 10/4/22.
//

import SwiftUI

struct SessionActionButton: View {
    
    let text: String
    let symbol: String
    @Binding var action: Bool
    
    var body: some View {
        Button {
            self.action.toggle()
        } label: {
            Label(text, systemImage: symbol)
        }
        .buttonStyle(.bordered)
    }
}



struct SessionActionButton_Previews: PreviewProvider {
    
    static var previews: some View {
        SessionActionButton(text: "Personalize", symbol: SFSymbols.hourglass, action: .constant(false))
        
    }
}

