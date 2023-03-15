//
//  ContentView.swift
//  Moonshot
//
//  Created by Axel Collard Bovy on 29/8/22.
//

import SwiftUI

struct ContentView: View {
    let astronauts = Bundle.main.decode("astronauts.json")

    var body: some View {
        Text("Hello, world! \(astronauts.count) astronauts")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
