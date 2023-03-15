//
//  ListLayout.swift
//  Moonshot
//
//  Created by Axel Collard Bovy on 10/9/22.
//

import SwiftUI

struct ListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]

    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        Spacer()
                        VStack(spacing: 16) {
                            Text(mission.displayName)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.system(size: 16))
                                .foregroundColor(.white.opacity(0.5))
                        }
                        Spacer()
                    }
                }
            }
            .listRowBackground(Color.darkBackground)
        }
        .listStyle(.plain)
    }
}

struct ListLayout_Previews: PreviewProvider {
    static var previews: some View {
        ListLayout(astronauts: Bundle.main.decode("astronauts.json"),
                   missions: Bundle.main.decode("missions.json"))
    }
}
