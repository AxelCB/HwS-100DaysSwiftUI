//
//  Location.swift
//  BucketList
//
//  Created by Axel Collard Bovy on 19/2/23.
//

import Foundation
import MapKit

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }

    static let example = Location(id: UUID(),
                                  name: "Buckingham Palace",
                                  description: "Where Queen Elizabeth lived with her dorgis.",
                                  latitude: 51.501,
                                  longitude: -0.141)
}
