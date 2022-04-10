//
//  changeAmountButtonView.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 10/4/22.
//

import SwiftUI

struct changeAmountButtonView: View {
    var imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .foregroundColor(.brandPrimary)
            .font(.system(size: 35))
            .font(Font.body.weight(.ultraLight))
    }
}


struct changeAmountButtonView_Previews: PreviewProvider {
    static var previews: some View {
        changeAmountButtonView(imageName: SFSymbols.plus)
    }
}
