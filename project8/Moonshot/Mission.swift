//
//  Mission.swift
//  Moonshot
//
//  Created by Axel Collard Bovy on 3/9/22.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
