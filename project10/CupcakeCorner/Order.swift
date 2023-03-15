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

        var order: Double {
            switch self {
            case .vanilla:
                return 0
            case .strawberry:
                return 1
            case .chocolate:
                return 2
            case .rainbow:
                return 3
            }
        }
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

    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""

    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }

        return true
    }

    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(flavour.order) / 2)

        // $1/cake for extra frosting
        if addExtraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addExtraSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}
