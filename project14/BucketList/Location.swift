//
//  Location.swift
//  BucketList
//
//  Created by Axel Collard Bovy on 19/2/23.
//

import Foundation
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
