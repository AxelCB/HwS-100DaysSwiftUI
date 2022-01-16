//
//  ConverterView.swift
//  WeConvertUnits
//
//  Created by Axel Collard Bovy on 11/01/2022.
//

import SwiftUI

struct ConverterSelectionView: View {
    @State private var selectedConverterType = ConversionType.temperature
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Type", selection: $selectedConverterType) {
                        ForEach(ConversionType.allCases, id: \.self) { type in
                            Text(type.rawValue.capitalized)
                        }
                    }
                }
                
                switch selectedConverterType {
                case .temperature:
                    TemperatureConverterView()
                case .length:
                    LengthConverterView()
                case .time:
                    TimeConverterView()
                case .volume:
                    VolumeConverterView()
                }
            }
        }
    }
}

struct ConverterSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConverterSelectionView()
    }
}
