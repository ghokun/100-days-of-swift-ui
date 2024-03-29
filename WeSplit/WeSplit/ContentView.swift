//
//  ContentView.swift
//  WeSplit
//
//  Created by  Gokhun Celik on 19/03/2023.
//

import SwiftUI

struct ContentView: View {
  @State private var checkAmount = 0.0
  @State private var numberOfPeople = 2
  @State private var tipPercentage = 20
  @FocusState private var amountIsFocused: Bool

  let currency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
  let tipPercentages = [10, 15, 20, 25, 0]

  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let tipSelection = Double(tipPercentage)
    let tipValue = checkAmount / 100 * tipSelection
    let grandTotal = checkAmount + tipValue
    return grandTotal / peopleCount
  }

  var totalAmount: Double {
    let tipSelection = Double(tipPercentage) / 100
    return checkAmount * (1 + tipSelection)
  }

  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField(
            "Amount",
            value: $checkAmount,
            format: currency
          )
          .keyboardType(.decimalPad)
          .focused($amountIsFocused)
          Picker("Number of People", selection: $numberOfPeople) {
            ForEach(2 ..< 100) {
              Text("\($0) people")
            }
          }.pickerStyle(.menu)
        }

        Section {
          Picker("Tip Percentage", selection: $tipPercentage) {
            ForEach(tipPercentages, id: \.self) {
              Text($0, format: .percent)
            }
          }
          .pickerStyle(.segmented)
        } header: {
          Text("How much tip do you want to leave?")
        }

        Section {
          Text(totalPerPerson, format: currency)
        } header: {
          Text("Amount per person")
        }

        Section {
          Text(totalAmount, format: currency)
        } header: {
          Text("Total amount")
        }
      }
      .navigationTitle("We Split")
      .toolbar {
        ToolbarItemGroup(placement: .keyboard) {
          Spacer()
          Button("Done") {
            amountIsFocused = false
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
