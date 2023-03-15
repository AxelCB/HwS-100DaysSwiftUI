//
//  ContentView.swift
//  BucketList
//
//  Created by Axel Collard Bovy on 18/2/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
                .onTapGesture(perform: loadFile)
        }
        .padding()
    }

    func loadFile() {
        let str = "Test Message"

        do {
            try FileManager.default.writeJSON(str, toFile: "message.txt")
            let input: String = try FileManager.default.readJSON(fromFile: "message.txt")
            print(input)
        } catch {
            print(error.localizedDescription)
        }
    }

    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
