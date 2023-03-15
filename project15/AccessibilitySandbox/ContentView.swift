//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Axel Collard Bovy on 26/2/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Image(decorative: "character")
                .accessibilityHidden(true)
            VStack {
                Text("Your score is")
                Text("1000")
                    .font(.title)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Your score is 1000")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
