//
//  Prospect.swift
//  HotProspects
//
//  Created by Axel Collard Bovy on 2/3/23.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let prospectsFileName = "Prospects.json"

    init() {
        do {
            people = try FileManager.default.readJSON(fromFile: prospectsFileName)
        } catch {
            print("Could not read people list from json file")
            people = []
        }
    }

    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }

    private func save() {
        do {
            try FileManager.default.writeJSON(people, toFile: prospectsFileName)
        } catch {
            print("Could not save people list")
        }
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
