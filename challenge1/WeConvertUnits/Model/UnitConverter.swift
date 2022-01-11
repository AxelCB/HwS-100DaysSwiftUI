//
//  UnitConverter.swift
//  WeConvertUnits
//
//  Created by Axel Collard Bovy on 09/01/2022.
//

import Foundation

enum ConversionType {
    case temperature
    case length
    case time
    case volume
}

protocol UnitConverter {
    associatedtype Unit: UnitProtocol
    
    func convert(_ input: Unit, to: Unit.UnitType) -> Unit
}

extension UnitConverter {
    func convert(_ input: Unit, to destinationType: Unit.UnitType) -> Unit {
        Unit(fromBaseValue: input.baseValue, to: destinationType)
    }
}

protocol UnitProtocol {
    associatedtype Value
    associatedtype UnitType
    
    var value: Value { get }
    var baseValue: Value { get }
    var type: UnitType { get }
    
    init(fromBaseValue: Value, to destinationType: UnitType)
}
