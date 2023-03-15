//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Axel Collard Bovy on 25/9/22.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderViewModel: OrderViewModel

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderViewModel.order.name)
                TextField("Street Address", text: $orderViewModel.order.streetAddress)
                TextField("City", text: $orderViewModel.order.city)
                TextField("Zip", text: $orderViewModel.order.zip)
            }

            Section {
                NavigationLink {
                    CheckoutView(orderViewModel: orderViewModel)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(orderViewModel.order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orderViewModel: OrderViewModel())
    }
}
