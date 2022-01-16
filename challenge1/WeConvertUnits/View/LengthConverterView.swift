//
//  LengthConverterView.swift
//  WeConvertUnits
//
//  Created by Axel Collard Bovy on 14/01/2022.
//

import SwiftUI

struct LengthConverterView: View {
    private let converter = LengthConverter()
    @State private var inputUnitType: LengthConverter.UnitType = .meters
    @State private var inputUnitValue = ""
    
    @State private var outputUnitType: LengthConverter.UnitType = .meters
    
    var body: some View {
        Section {
            Picker("Type", selection: $inputUnitType) {
                ForEach(LengthConverter.UnitType.allCases, id: \.self) { type in
                    Text(type.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            
            TextField("Enter a value", text: $inputUnitValue)
                .keyboardType(.decimalPad)
        }
        
        Section {
            Picker("Type", selection: $outputUnitType) {
                ForEach(LengthConverter.UnitType.allCases, id: \.self) { type in
                    Text(type.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            
            Text("\(outputValue)")
        }
    }
    
    var outputValue: Double {
        converter.convert((inputUnitValue as NSString).doubleValue, from: inputUnitType, to: outputUnitType)
    }
}

struct LengthConverterView_Previews: PreviewProvider {
    static var previews: some View {
        LengthConverterView()
    }
}
