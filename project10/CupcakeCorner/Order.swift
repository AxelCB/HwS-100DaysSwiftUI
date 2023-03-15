//
//  Order.swift
//  CupcakeCorner
//
//  Created by Axel Collard Bovy on 24/9/22.
//

import Foundation

final class Order: ObservableObject, Codable {
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

    init() { }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        flavour = try container.decode(Flavour.self, forKey: .flavour)
        quantity = try container.decode(Int.self, forKey: .quantity)

        addExtraFrosting = try container.decode(Bool.self, forKey: .addExtraFrosting)
        addExtraSprinkles = try container.decode(Bool.self, forKey: .addExtraSprinkles)

        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(flavour, forKey: .flavour)
        try container.encode(quantity, forKey: .quantity)

        try container.encode(addExtraFrosting, forKey: .addExtraFrosting)
        try container.encode(addExtraSprinkles, forKey: .addExtraSprinkles)

        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
}
