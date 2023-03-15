//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Axel Collard Bovy on 8/2/23.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
