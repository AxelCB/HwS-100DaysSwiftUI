//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Axel Collard Bovy on 5/7/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .largeBlueTitleStyle()
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
