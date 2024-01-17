//
//  ContentView.swift
//  iExpense
//
//  Created by Ivan Tilev on 15.11.23.
//

import SwiftUI

// Struct that represents a single expence
struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

// Storing ExpenseItems in a array
@Observable
class Expenses {
    var items = [ExpenseItem]()
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    // 1. Keep track if second view have to be shown
    @State private var showAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add expense", systemImage: "plus") {
                    // 5. Changing the showAddExpense to true and trigger the second screen when + is tapped
                    showAddExpense = true
                }
            }
            .sheet(isPresented: $showAddExpense) {
                // 2. Show second view
                AddView(expenses: expenses)
            }
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
