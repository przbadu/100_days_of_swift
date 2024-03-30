//
//  ContentView.swift
//  UnitConversion
//
//  Created by przbadu on 29/03/2024.
//

import SwiftUI

enum ConversionTypes: String, Equatable, CaseIterable {
    case temperature = "Temperature"
    case length = "Length"
    case time = "time"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

enum Temperature: String, Equatable, CaseIterable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

enum Length: String, Equatable, CaseIterable {
    case meters = "Meters (m)"
    case kilometers = "Kilometers (km)"
    case feet = "Feet (ft)"
    case yards = "Yards"
    case miles = "Miles"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

enum Time: String, Equatable, CaseIterable {
    case milliseconds = "Milliseconds"
    case seconds = "Seconds"
    case minutes = "Minutes"
    case hours = "Hours"
    case days = "Days"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}


struct ContentView: View {
    let defaultTemperature = Temperature.celsius
    let defaultLength = Length.meters
    let defaultTime = Time.seconds
    
    @State private var conversionType = ConversionTypes.length
    @State private var temperatureTo = Temperature.fahrenheit
    @State private var lengthTo = Length.kilometers
    @State private var timeTo = Time.milliseconds

    @State private var from = 1.0
    @State private var to = 0.0
    
    var sectionName: String {
        switch conversionType {
        case .temperature:
            return "Temperature"
        case .length:
            return "Length"
        case .time:
            return "Time"
        }
    }
    
    
    var calculateToValue: any Numeric {
        switch conversionType {
        case .temperature:
            return toTemperature
        case .length:
            return toLength
        case .time:
            return toTime
        }
    }
    
    var toTemperature: Double {
        switch temperatureTo {
        case .celsius:
            return from
        case .fahrenheit:
            return (from * 9 / 5) + 32
        case .kelvin:
            return from + 273.15
        }
    }
    
    var toLength: Double {
        switch lengthTo {
        case .meters:
            return from
        case .kilometers:
            return from / 1000
        case .feet:
            return from * 3.28084
        case .yards:
            return from * 1.09361
        case .miles:
            return from / 1609
        }
    }
    
    var toTime: Double {
        switch timeTo {
        case .milliseconds:
            return from * 1000
        case .seconds:
            return from
        case .minutes:
            return from / 60
        case .hours:
            return from / 3600
        case .days:
            return from / 86400
        }
    }
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Select conversion type") {
                    Picker("Unit", selection: $conversionType) {
                        ForEach(ConversionTypes.allCases, id: \.self) {
                            Text($0.localizedName)
                                .tag($0)
                        }
                    }
                }
                
                Section("Convert \(conversionType) from") {
                    HStack {
                        TextField("from", value: $from, format: .number)
                            .keyboardType(.decimalPad)
                        
                        switch conversionType {
                        case .temperature:
                            Text(defaultTemperature.localizedName)
                        case .length:
                            Text(defaultLength.localizedName)
                        case .time:
                            Text(defaultTime.localizedName)
                        }
                    }
                }
                
                Section("Result") {
                    HStack {
                        Text("\(calculateToValue)")
                        
                        switch conversionType {
                        case .temperature:
                            Picker("", selection: $temperatureTo) {
                                ForEach(Temperature.allCases, id: \.self) {
                                    Text($0.localizedName)
                                        .tag($0)
                                }
                            }
                        case .length:
                            Picker("", selection: $lengthTo) {
                                ForEach(Length.allCases, id: \.self) {
                                    Text($0.localizedName)
                                        .tag($0)
                                }
                            }
                        case .time:
                            Picker("", selection: $timeTo) {
                                ForEach(Time.allCases, id: \.self) {
                                    Text($0.localizedName)
                                        .tag($0)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Unit Converter")
        }
    }
}

#Preview {
    ContentView()
}
