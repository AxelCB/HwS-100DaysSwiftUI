//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Axel Collard Bovy on 25/9/22.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderViewModel: OrderViewModel
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var showingAlert = false

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(orderViewModel.order.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
    }

    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(orderViewModel.order) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            alertTitle = "Thank you!"
            alertMessage = "Your order for \(decodedOrder.quantity)x \(decodedOrder.flavour.rawValue.lowercased()) cupcakes is on its way!"
            showingAlert = true
        } catch {
            alertTitle = "Checkout Failed"
            alertMessage = "Please, try again later"
            showingAlert = true
            print("Checkout failed.")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(orderViewModel: OrderViewModel())
    }
}
