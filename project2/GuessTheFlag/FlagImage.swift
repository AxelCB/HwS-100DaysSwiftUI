//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Axel Collard Bovy on 31/7/22.
//

import SwiftUI

struct FlagImage: View {
    let flagName: String

    var body: some View {
        Image(flagName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(flagName: "Ireland")
    }
}
