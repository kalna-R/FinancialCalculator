//
//  TextFieldFocusStyleViewModifier.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/23/23.
//

import SwiftUI

struct TextFieldFocusedStyle: ViewModifier {
    
    @Binding var isFocused: Bool
    
    func body(content: Content) -> some View {
        content
            .border(isFocused ? Color.blue : Color.clear, width: 2)
            .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { _ in
                self.isFocused = true
            }
            .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidEndEditingNotification)) { _ in
                self.isFocused = false
            }
    }
}

extension View {
    func textFieldFocusedStyle(isFocused: Binding<Bool>) -> some View {
        self.modifier(TextFieldFocusedStyle(isFocused: isFocused))
    }
}
