//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Axel Collard Bovy on 2/3/23.
//

import SwiftUI

struct ProspectsView: View {
    let filter: FilterType

    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }

    var body: some View {
        NavigationView {
            Text("Hello, World!")
                .navigationTitle(title)
        }
    }

    enum FilterType {
        case none, contacted, uncontacted
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
