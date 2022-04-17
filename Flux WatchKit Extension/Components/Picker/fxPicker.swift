//
//  Picker.swift
//  Flux WatchKit Extension
//
//  Created by Christian Skorobogatow on 14/4/22.
//

import SwiftUI

import SwiftUI

struct FxPicker: View {
    
    let label: String
    var unit: [Int]

    @Binding var selected: Int
    
    var body: some View {
        VStack {
            HStack {
                Picker(label, selection: $selected) {
                    ForEach(unit, id: \.self) {
                        Text("\($0)")
                    }
                }
            }
        }
    }
}

struct PickerF_Previews: PreviewProvider {
    
    static var previews: some View {
        FxPicker(label: "", unit: [1,2,3,4,5],
                 selected: .constant(1))
    }
}

