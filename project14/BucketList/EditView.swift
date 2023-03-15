//
//  EditView.swift
//  BucketList
//
//  Created by Axel Collard Bovy on 20/2/23.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: ViewModel
    @State private var name: String
    @State private var description: String
    var onSave: (Location) -> Void

    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave

        _name = State(initialValue: location.name)
        _description = State(initialValue: location.description)
        _viewModel = StateObject(wrappedValue: ViewModel(location:  location))
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $name)
                    TextField("Description", text: $description)
                }
                Section("Nearby…") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    let newLocation = viewModel.createNewLocation(withName: name, andDescription: description)
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { newLocation in }
    }
}
