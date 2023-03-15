//
//  Order.swift
//  CupcakeCorner
//
//  Created by Axel Collard Bovy on 24/9/22.
//

import Foundation

struct Order: Codable {
    enum Flavour: String, CaseIterable, Codable {
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

    var flavour = Flavour.vanilla
    var quantity = 3

    var isSpecialRequest = false {
        didSet {
            if isSpecialRequest == false {
                addExtraFrosting = false
                addExtraSprinkles = false
            }
        }
    }
    var addExtraFrosting = false
    var addExtraSprinkles = false

    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""

    enum CodingKeys: CodingKey {
        case flavour, quantity, addExtraFrosting, addExtraSprinkles, name, streetAddress, city, zip
    }

    var hasValidAddress: Bool {
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        guard !streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        guard !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        guard !zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
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
