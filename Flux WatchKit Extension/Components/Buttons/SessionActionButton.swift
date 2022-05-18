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
        HStack {
            Button {
                self.action.toggle()
            } label: {
                Label(text, systemImage: symbol)
                    .lineLimit(1)
                    .minimumScaleFactor(0.25)
            }
            .buttonStyle(.bordered)
            .padding(.horizontal)
        }
    }
}



struct SessionActionButton_Previews: PreviewProvider {
    
    static var previews: some View {
        SessionActionButton(text: "Weekly Summary", symbol: SFSymbols.hourglass, action: .constant(false))
        
    }
}

