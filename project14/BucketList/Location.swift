//
//  Location.swift
//  BucketList
//
//  Created by Axel Collard Bovy on 19/2/23.
//

import Foundation
import MapKit

struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let description: String
    let latitude: Double
    let longitude: Double
}
