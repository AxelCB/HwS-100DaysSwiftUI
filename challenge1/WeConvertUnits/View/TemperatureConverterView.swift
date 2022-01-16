//
//  TemperatureConverterView.swift
//  WeConvertUnits
//
//  Created by Axel Collard Bovy on 14/01/2022.
//

import SwiftUI

struct TemperatureConverterView: View {
    private let converter = TemperatueConverter()
    @State private var inputUnitType: TemperatueConverter.UnitType = .celsius
    @State private var inputUnitValue = ""
    
    @State private var outputUnitType: TemperatueConverter.UnitType = .celsius
    
    var body: some View {
        Section {
            Picker("Type", selection: $inputUnitType) {
                ForEach(TemperatueConverter.UnitType.allCases, id: \.self) { type in
                    Text(type.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            
            TextField("Enter a value", text: $inputUnitValue)
                .keyboardType(.decimalPad)
        }
        
        Section {
            Picker("Type", selection: $outputUnitType) {
                ForEach(TemperatueConverter.UnitType.allCases, id: \.self) { type in
                    Text(type.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            
            Text(outputValue.formatted())
        }
    }
    
    var outputValue: Double {
        converter.convert((inputUnitValue as NSString).doubleValue, from: inputUnitType, to: outputUnitType)
    }
}

struct TemperatureConverterView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureConverterView()
    }
}
