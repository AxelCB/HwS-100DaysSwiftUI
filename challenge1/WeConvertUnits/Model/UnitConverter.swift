//
//  UnitConverter.swift
//  WeConvertUnits
//
//  Created by Axel Collard Bovy on 09/01/2022.
//

import Foundation

enum ConversionType: String, CaseIterable {
    case temperature
    case length
    case time
    case volume
}

protocol UnitConverter {
    associatedtype UnitValue
    associatedtype UnitType

    func convert(_ input: UnitValue, from originType: UnitType, to destinationType: UnitType) -> UnitValue
}
