//
//  VolumeConverter.swift
//  WeConvertUnits
//
//  Created by Axel Collard Bovy on 16/01/2022.
//

import Foundation

struct VolumeConverter: UnitConverter {
    func convert(_ input: Double, from originType: UnitType, to destinationType: UnitType) -> Double {
        let baseValue = baseValue(from: input, unitType: originType)
        
        switch destinationType {
        case .milliliters:
            return baseValue
        case .liters:
            return baseValue / 1000
        case .cups:
            return baseValue / 237
        case .pints:
            return baseValue / 473
        case .gallons:
            return baseValue / 3785
        }
    }
    
    private func baseValue(from value: Double, unitType: UnitType) -> Double {
        switch unitType {
        case .milliliters:
            return value
        case .liters:
            return value * 1000
        case .cups:
            return value * 237
        case .pints:
            return value * 473
        case .gallons:
            return value * 3785
        }
    }
    
    enum UnitType: String, CaseIterable {
        case milliliters
        case liters
        case cups
        case pints
        case gallons
    }

}
