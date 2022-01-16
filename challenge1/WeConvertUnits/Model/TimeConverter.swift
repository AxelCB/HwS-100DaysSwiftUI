//
//  TimeConverter.swift
//  WeConvertUnits
//
//  Created by Axel Collard Bovy on 11/01/2022.
//

import Foundation

struct TimeConverter: UnitConverter {
    func convert(_ input: Double, from originType: UnitType, to destinationType: UnitType) -> Double {
        let baseValue = baseValue(from: input, unitType: originType)
        
        switch destinationType {
        case .seconds:
            return baseValue
        case .minutes:
            return baseValue / 60
        case .hours:
            return baseValue / 360
        case .days:
            return baseValue / 360 / 24
        }
    }
    
    private func baseValue(from value: Double, unitType: UnitType) -> Double {
        switch unitType {
        case .seconds:
            return value
        case .minutes:
            return value * 60
        case .hours:
            return value * 360
        case .days:
            return value * 360 * 24
        }
    }
    
    enum UnitType: String, CaseIterable {
        case seconds
        case minutes
        case hours
        case days
    }

}
