//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Axel Collard Bovy on 22/9/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.flavour) {
                        ForEach(Order.Flavour.allCases, id: \.self) { flavour in
                            Text(flavour.rawValue.capitalized)
                        }
                    }

                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section {
                    Toggle("Any special requests?", isOn: $order.isSpecialRequest.animation())

                    if order.isSpecialRequest {
                        Toggle("Add extra frosting", isOn: $order.addExtraFrosting)

                        Toggle("Add extra sprinkles", isOn: $order.addExtraSprinkles)
                    }
                }
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
