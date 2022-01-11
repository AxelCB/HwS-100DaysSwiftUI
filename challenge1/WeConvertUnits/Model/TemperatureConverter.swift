//
//  TemperatureConverter.swift
//  WeConvertUnits
//
//  Created by Axel Collard Bovy on 09/01/2022.
//

import Foundation

struct TemperatueConverter: UnitConverter {
    struct Unit: UnitProtocol {
        let type: UnitType
        let value: Double
        
        init(fromBaseValue baseValue: Double, to unitType: UnitType) {
            type = unitType
            
            switch unitType {
            case .celsius:
                value = baseValue - 273.15
            case .fahrenheit:
                value = (baseValue - 273.15) * 9/5 + 32
            case .kelvin:
                value = baseValue
            }
        }
        
        var baseValue: Double {
            switch type {
            case .celsius:
                return value + 273.15
            case .fahrenheit:
                return (value - 32) * 5/9 + 273.15
            case .kelvin:
                return value
            }
        }
    }
    
    enum UnitType {
        case celsius
        case fahrenheit
        case kelvin
    }
}
