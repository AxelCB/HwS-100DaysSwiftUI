//
//  TimeConverterView.swift
//  WeConvertUnits
//
//  Created by Axel Collard Bovy on 14/01/2022.
//

import SwiftUI

struct TimeConverterView: View {
    private let converter = TimeConverter()
    @State private var inputUnitType: TimeConverter.UnitType = .seconds
    @State private var inputUnitValue = ""
    
    @State private var outputUnitType: TimeConverter.UnitType = .minutes
    
    var body: some View {
        Section {
            Picker("Type", selection: $inputUnitType) {
                ForEach(TimeConverter.UnitType.allCases, id: \.self) { type in
                    Text(type.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            
            TextField("Enter a value", text: $inputUnitValue)
                .keyboardType(.decimalPad)
        }
        
        Section {
            Picker("Type", selection: $outputUnitType) {
                ForEach(TimeConverter.UnitType.allCases, id: \.self) { type in
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

struct TimeConverterView_Previews: PreviewProvider {
    static var previews: some View {
        TimeConverterView()
    }
}
