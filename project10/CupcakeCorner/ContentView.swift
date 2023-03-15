//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Axel Collard Bovy on 22/9/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var orderViewModel = OrderViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $orderViewModel.order.flavour) {
                        ForEach(Order.Flavour.allCases, id: \.self) { flavour in
                            Text(flavour.rawValue.capitalized)
                        }
                    }

                    Stepper("Number of cakes: \(orderViewModel.order.quantity)", value: $orderViewModel.order.quantity, in: 3...20)
                }
                Section {
                    Toggle("Any special requests?", isOn: $orderViewModel.order.isSpecialRequest.animation())

                    if orderViewModel.order.isSpecialRequest {
                        Toggle("Add extra frosting", isOn: $orderViewModel.order.addExtraFrosting)

                        Toggle("Add extra sprinkles", isOn: $orderViewModel.order.addExtraSprinkles)
                    }
                }
                Section {
                    NavigationLink {
                        AddressView(orderViewModel: orderViewModel)
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
