//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Axel Collard Bovy on 20/2/23.
//

import Foundation
import MapKit
import LocalAuthentication

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        let savePath = "SavedPlaces"
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
                                                        span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        @Published var authenticationError: Error?

        var isShowingError: Bool {
            get {
                authenticationError != nil
            }
            set {
                if !newValue {
                    authenticationError = nil
                }
            }
        }

        init() {
            do {
                locations = try FileManager.default.readJSON(fromFile: savePath)
            } catch {
                locations = []
            }
        }

        func addLocation() {
            let newLocation = Location(id: UUID(),
                                       name: "New location",
                                       description: "",
                                       latitude: mapRegion.center.latitude,
                                       longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }

        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }

            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }

        func save() {
            do {
                try FileManager.default.writeJSON(locations, toFile: savePath)
            } catch {
                print("Unable to save data")
            }
        }

        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                    if success {
                        Task { @MainActor in
                            self.isUnlocked = true
                        }
                    } else {
                        self.authenticationError = authenticationError
                    }
                }
            } else {
                // no biometrics
            }
        }
    }
}
