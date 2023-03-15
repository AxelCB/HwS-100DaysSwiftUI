//
//  Order.swift
//  CupcakeCorner
//
//  Created by Axel Collard Bovy on 24/9/22.
//

import Foundation

final class Order: ObservableObject {
    enum Flavour: String, CaseIterable {
        case vanilla
        case strawberry
        case chocolate
        case rainbow
    }

    @Published var flavour = Flavour.vanilla
    @Published var quantity = 3

    @Published var isSpecialRequest = false {
        didSet {
            if isSpecialRequest == false {
                addExtraFrosting = false
                addExtraSprinkles = false
            }
        }
    }
    @Published var addExtraFrosting = false
    @Published var addExtraSprinkles = false
}
