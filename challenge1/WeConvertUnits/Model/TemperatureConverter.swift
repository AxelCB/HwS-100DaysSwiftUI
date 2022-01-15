//
//  TemperatureConverter.swift
//  WeConvertUnits
//
//  Created by Axel Collard Bovy on 09/01/2022.
//

import Foundation

struct TemperatueConverter: UnitConverter {
    func convert(_ input: Double, from originType: UnitType, to destinationType: UnitType) -> Double {
        let baseValue = baseValue(from: input, unitType: originType)
        
        switch destinationType {
        case .celsius:
            return baseValue - 273.15
        case .fahrenheit:
            return (baseValue - 273.15) * 9/5 + 32
        case .kelvin:
            return baseValue
        }
    }
    
    private func baseValue(from value: Double, unitType: UnitType) -> Double {
        switch unitType {
        case .celsius:
            return value + 273.15
        case .fahrenheit:
            return (value - 32) * 5/9 + 273.15
        case .kelvin:
            return value
        }
    }
    
    enum UnitType: String, CaseIterable {
        case celsius
        case fahrenheit
        case kelvin
    }
}
