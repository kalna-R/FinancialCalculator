//
//  NumericOnlyFieldViewModifier.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/23/23.
//

import SwiftUI
import Combine

struct NumbersOnlyViewModifier: ViewModifier {
    
    @Binding var text: String
    
    var includeDecimal: Bool
    
    func body(content: Content) -> some View {
        content
            .keyboardType(includeDecimal ? .decimalPad : .numberPad)
            .onReceive(Just(text)) { newValue in
                var numbers = "0123456789"
                let decimalSeparator: String = Locale.current.decimalSeparator ?? "."
                if includeDecimal {
                    numbers += decimalSeparator
                }
                if newValue.components(separatedBy: decimalSeparator).count-1 > 1 { // check if more than one seperator is entered
                    let filtered = newValue
                    self.text = limitDecimalPlaces(newValue: String(filtered.dropLast()), decimalSeparator: decimalSeparator)
                    
                } else {
                    let filtered = newValue.filter { numbers.contains($0)}
                    if filtered != newValue {
                        self.text = limitDecimalPlaces(newValue: filtered, decimalSeparator: decimalSeparator)
                    }
                    else {
                        self.text = limitDecimalPlaces(newValue: newValue, decimalSeparator: decimalSeparator)
                    }
                }
            }
    }
    
    private func limitDecimalPlaces(newValue: String, decimalSeparator: String) -> String {
        guard includeDecimal, !text.isEmpty else { // should be decimal & value != null
            return newValue
        }
        
        let component = newValue.components(separatedBy: decimalSeparator)
        if component.count > 1 { // multiple decimal points found
            guard let last = component.last else {
                return newValue
            }
            if last.count > 2 { // allow only 2 decimal points
                let filtered = newValue
                return String(filtered.dropLast())
            }
        }
        return newValue
    }
}

extension View {
    func numbersOnly(_ text: Binding<String>, includeDecimal: Bool = false) -> some View {
        self.modifier(NumbersOnlyViewModifier(text: text, includeDecimal: includeDecimal))
    }
}
