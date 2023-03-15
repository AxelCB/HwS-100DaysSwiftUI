//
//  MapSample.swift
//  BucketList
//
//  Created by Axel Collard Bovy on 19/2/23.
//

import SwiftUI
import MapKit

struct MapSample: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
                                                      span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))

    var body: some View {
        Map(coordinateRegion: $mapRegion)
    }
}

struct MapSample_Previews: PreviewProvider {
    static var previews: some View {
        MapSample()
    }
}
