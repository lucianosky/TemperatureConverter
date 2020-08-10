//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Luciano Sclovsky on 09/08/20.
//  Copyright © 2020 Luciano Sclovsky. All rights reserved.
//

import SwiftUI

enum TemperatureScale: String, CaseIterable {
    case celsius = "C"
    case farenheit = "F"
    case kelvin = "K"
    
    private func f_to_c(f: Int) -> Int {
        return Int((f - 32) * 5/9)
    }

    private func c_to_f(c: Int) -> Int {
        return Int(c * 9/5 + 32)
    }

    private func c_to_k(c: Int) -> Int {
        return c + 273
    }

    private func k_to_c(k: Int) -> Int {
        return k - 273
    }

    func convert(temperature t: Int, to: TemperatureScale) -> Int {
        
        switch self {
        case .celsius:
            switch to {
            case .celsius:
                return t
            case .farenheit:
                return c_to_f(c: t)
            case .kelvin:
                return c_to_k(c: t)
            }
            
        case .farenheit:
            switch to {
            case .celsius:
                return f_to_c(f: t)
            case .farenheit:
                return t
            case .kelvin:
                return c_to_k(c: f_to_c(f: t))
            }
            
        case .kelvin:
            switch to {
            case .celsius:
                return k_to_c(k: t)
            case .farenheit:
                return c_to_f(c: k_to_c(k: t))
            case .kelvin:
                return t
            }
        }
        
    }
}

struct ContentView: View {
    @State private var fromScale = TemperatureScale.celsius
    @State private var toScale = TemperatureScale.celsius
    @State private var inputValue = ""
    
    private var outputValue: String {
        guard let fromTemperature = Int(inputValue) else { return "Degrees" }
        print(fromScale, toScale)
        return String( fromScale.convert(temperature: fromTemperature, to: toScale))
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Convert")) {
                    
                    HStack {
                        Text("From")
                        Spacer()
                        TextField("Degrees", text: $inputValue)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    Picker(selection: $fromScale, label: Text("Position")) {
                        ForEach(TemperatureScale.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                }
                Section() {
                    HStack {
                        Text("To")
                        Spacer()
                        Text(outputValue)
                    }
                    Picker(selection: $toScale, label: Text("Position")) {
                        ForEach(TemperatureScale.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Temperature Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

