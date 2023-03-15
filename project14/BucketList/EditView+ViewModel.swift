//
//  EditView+ViewModel.swift
//  BucketList
//
//  Created by Axel Collard Bovy on 22/2/23.
//

import Foundation

extension EditView {
    @MainActor class ViewModel: ObservableObject {
        @Published private var location: Location
        @Published private(set) var loadingState = LoadingState.loading
        @Published private(set) var pages = [Page]()

        init(location: Location, loadingState: LoadingState = LoadingState.loading, pages: [Page] = [Page]()) {
            self.location = location
            self.loadingState = loadingState
            self.pages = pages
        }

        func createNewLocation(withName name: String, andDescription description: String) -> Location {
            Location(id: UUID(),
                     name: name,
                     description: description,
                     latitude: location.latitude,
                     longitude: location.longitude)
        }

        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)

                // we got some data back!
                let items = try JSONDecoder().decode(Result.self, from: data)

                // success – convert the array values to our pages array
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                // if we're still here it means the request failed somehow
                loadingState = .failed
            }
        }

        enum LoadingState {
            case loading, loaded, failed
        }
    }
}
