//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Axel Collard Bovy on 28/8/22.
//

import Foundation

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
