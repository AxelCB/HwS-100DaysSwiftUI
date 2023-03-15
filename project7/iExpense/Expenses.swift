//
//  Expenses.swift
//  iExpense
//
//  Created by Axel Collard Bovy on 28/8/22.
//

import Foundation

final class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
