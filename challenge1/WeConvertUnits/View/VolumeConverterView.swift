//
//  VolumeConverterView.swift
//  WeConvertUnits
//
//  Created by Axel Collard Bovy on 14/01/2022.
//

import SwiftUI

struct VolumeConverterView: View {
    private let converter = VolumeConverter()
    @State private var inputUnitType: VolumeConverter.UnitType = .milliliters
    @State private var inputUnitValue = ""
    
    @State private var outputUnitType: VolumeConverter.UnitType = .liters
    
    var body: some View {
        Section {
            Picker("Type", selection: $inputUnitType) {
                ForEach(VolumeConverter.UnitType.allCases, id: \.self) { type in
                    Text(type.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            
            TextField("Enter a value", text: $inputUnitValue)
                .keyboardType(.decimalPad)
        }
        
        Section {
            Picker("Type", selection: $outputUnitType) {
                ForEach(VolumeConverter.UnitType.allCases, id: \.self) { type in
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

struct VolumeConverterView_Previews: PreviewProvider {
    static var previews: some View {
        VolumeConverterView()
    }
}
