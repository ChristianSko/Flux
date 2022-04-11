//
//  fxlabel.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 10/4/22.
//

import SwiftUI

struct fxlabel: View {
    
    let text: String
    let fontweight: Font.Weight
    let type: Font
    
    var body: some View {
    
        Text(text)
            .font(type)
            .fontWeight(fontweight)
            .foregroundColor(Color.brandPrimary)
        
    }
}


struct fxlabel_Previews: PreviewProvider {
    static var previews: some View {
        fxlabel(text: "Test", fontweight: .bold, type: .body)
    }
}
