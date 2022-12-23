//
//  ContentView.swift
//  TemperatureConversion
//
//  Created by Ada Diniz on 21/12/22.
//

import SwiftUI

struct ContentView: View {
    @State private var temperatureAmountInput = 0.0
    @State private var temperatureScaleInput = ""
    @State private var temperatureScaleOutput = ""
    
    @State private var temperatureScales = ["Fahrenheit", "Kelvin", "Celsius"]
    
    @FocusState private var amountIsFocused: Bool

    
    var temperatureOutput: Double {
        let tempInput = Double(temperatureAmountInput)
        var tempOutput = 0.0
        
        if temperatureScaleInput == "Fahrenheit" && temperatureScaleOutput == "Kelvin" {
            tempOutput = (tempInput - 32) * 5/9 + 273
        } else if temperatureScaleInput == "Fahrenheit" && temperatureScaleOutput == "Celsius" {
            tempOutput = (tempInput - 32) / 1.8
        }
        
        if temperatureScaleInput == "Kelvin" && temperatureScaleOutput == "Fahrenheit" {
            tempOutput = (tempInput - 273) * 1.8 + 32
        } else if temperatureScaleInput == "Kelvin" && temperatureScaleOutput == "Celsius" {
            tempOutput = tempInput - 273
        }
        
        if temperatureScaleInput == "Celsius" && temperatureScaleOutput == "Fahrenheit" {
            tempOutput = tempInput * 1.8 + 32
        } else if temperatureScaleInput == "Celsius" && temperatureScaleOutput == "Kelvin" {
            tempOutput = tempInput + 273
        }
        
        if temperatureScaleInput == temperatureScaleOutput {
            tempOutput = tempInput
        }
                    
        return tempOutput
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Temperature amount", value: $temperatureAmountInput, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("", selection: $temperatureScaleInput){
                        ForEach(temperatureScales, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Temperature to be converted:")
                }
                
                Section {
                    Picker("", selection: $temperatureScaleOutput){
                        ForEach(temperatureScales, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("To which scale:")
                }
                
                Section{
                    Text("\(temperatureOutput.formatted()) \(temperatureScaleOutput)")
                } header: {
                    Text("Result:")
                }
            
            }
            .navigationTitle("TEMPERATURE CONVERSION")
            .navigationBarTitleDisplayMode(.inline)
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
