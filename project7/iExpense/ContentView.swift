//
//  ContentView.swift
//  iExpense
//
//  Created by Axel Collard Bovy on 24/8/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Business")) {
                    ForEach(expenses.businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }

                            Spacer()

                            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                .foregroundColor(item.amount > 100 ? .red : .black)
                                .font(.system(size: item.amount < 10 ? 14 : 16))
                        }
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("\(item.name) \(item.amount) \(Locale.current.currencyCode)")
                        .accessibilityHint(item.type)
                    }
                    .onDelete(perform: removeItems)
                }
                Section(header: Text("Personal")) {
                    ForEach(expenses.personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }

                            Spacer()

                            Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                .foregroundColor(item.amount > 100 ? .red : .black)
                                .font(.system(size: item.amount < 10 ? 14 : 16))
                        }
                    }
                    .onDelete { indexSet in
                        var updatedIndexSet = indexSet
                        updatedIndexSet.shift(startingAt: updatedIndexSet.first ?? 0, by: expenses.businessItems.count)
                        removeItems(at: updatedIndexSet)
                    }
                }

            }
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationTitle("iExpense")
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
