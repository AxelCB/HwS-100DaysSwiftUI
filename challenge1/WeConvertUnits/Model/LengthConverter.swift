//
//  LengthConverter.swift
//  WeConvertUnits
//
//  Created by Axel Collard Bovy on 16/01/2022.
//

import Foundation

struct LengthConverter: UnitConverter {
    func convert(_ input: Double, from originType: UnitType, to destinationType: UnitType) -> Double {
        let baseValue = baseValue(from: input, unitType: originType)
        
        switch destinationType {
        case .centimeters:
            return baseValue
        case .meters:
            return baseValue / 100
        case .kilometers:
            return baseValue / 100_000
        case .yards:
            return baseValue / 91.44
        case .feet:
            return baseValue / 30.48
        }
    }
    
    private func baseValue(from value: Double, unitType: UnitType) -> Double {
        switch unitType {
        case .centimeters:
            return value
        case .meters:
            return value * 100
        case .kilometers:
            return value * 100 * 1000
        case .yards:
            return value * 91.44
        case .feet:
            return value * 30.48
        }
    }
    
    enum UnitType: String, CaseIterable {
        case centimeters
        case meters
        case kilometers
        case yards
        case feet
    }

}
