//
//  ContentView.swift
//  WeShare
//
//  Created by przbadu on 28/03/2024.
//

import SwiftUI

struct ContentView: View {
    let tipPercentages = [10, 15, 20, 25, 0]
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercent = 20
    
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double {
        let numberOfPeople = Double(numberOfPeople)
        
        return totalAmount / numberOfPeople
    }
    
    var totalAmount: Double {
        let tipPercent = Double(tipPercent)
        
        return checkAmount + (checkAmount * tipPercent / 100)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter check amount: ", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people: ", selection: $numberOfPeople) {
                        ForEach(2...100, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip percentage: ", selection: $tipPercent) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total Amount") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Total Amount to pay per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                .navigationTitle("WeSplit")
                .toolbar {
                    if amountIsFocused {
                        Button("DONE") {
                            amountIsFocused = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
