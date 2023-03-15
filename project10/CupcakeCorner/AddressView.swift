//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Axel Collard Bovy on 25/9/22.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
        Text("Hello World")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
