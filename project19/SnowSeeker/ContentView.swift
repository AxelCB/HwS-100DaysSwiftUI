//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Axel Collard Bovy on 15/3/23.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")

    @State private var searchText = ""
    @State private var sortingOrder: Sorting = .loaded
    @StateObject var favorites = Favorites()

    var body: some View {
        NavigationView {
            Group {
                HStack {
                    Button("Default sorting") {
                        sortingOrder = .loaded
                    }
                        .foregroundColor(sortingOrder == .loaded ? .white : .accentColor)
                        .padding()
                        .background(sortingOrder == .loaded ? Color.accentColor : Color.white)
                        .cornerRadius(8)
                    Button("Sort by resort") {
                        sortingOrder = .resort
                    }
                        .foregroundColor(sortingOrder == .resort ? .white : .accentColor)
                        .padding()
                        .background(sortingOrder == .resort ? Color.accentColor : Color.white)
                        .cornerRadius(8)
                    Button("Sort by country") {
                        sortingOrder = .country
                    }
                        .foregroundColor(sortingOrder == .country ? .white : .accentColor)
                        .padding()
                        .background(sortingOrder == .country ? Color.accentColor : Color.white)
                        .cornerRadius(8)
                }


                List(orderedResorts) { resort in
                    NavigationLink {
                        ResortView(resort: resort)
                    } label: {
                        HStack{
                            Image(resort.country)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 25)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 5)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.black, lineWidth: 1)
                                )

                            VStack(alignment: .leading) {
                                Text(resort.name)
                                    .font(.headline)
                                Text("\(resort.runs) runs")
                                    .foregroundColor(.secondary)
                            }
                            if favorites.contains(resort) {
                                Spacer()
                                Image(systemName: "heart.fill")
                                    .accessibilityLabel("This is a favorite resort")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")

            WelcomeView()
        }
        .environmentObject(favorites)
    }

    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var orderedResorts: [Resort] {
        filteredResorts.sorted { lhs, rhs in
            switch sortingOrder {
            case .loaded:
                return false
            case .resort:
                return lhs.name < rhs.name
            case .country:
                return lhs.country < rhs.country
            }
        }
    }

    fileprivate enum Sorting {
        case loaded
        case resort
        case country
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
