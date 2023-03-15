//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Axel Collard Bovy on 8/2/23.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String, filterPredicate: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K \(filterPredicate.uppercased()) %@", filterKey, filterValue))
        self.content = content
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList(filterKey: "lastName", filterPredicate: "BEGINSWITH", filterValue: "Swift") { (singer: Singer) in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
}
