//
//  TextFieldStyleViewModifier.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/23/23.
//

import SwiftUI

struct TextFieldStyleViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white.cornerRadius(10))
            .overlay(
                RoundedRectangle(cornerRadius: 10.0)
                    .strokeBorder(Color.black.opacity(0.2), style: StrokeStyle(lineWidth: 1.0))
            )
            .foregroundColor(.black)
            .font(.headline)
    }
}

extension View {
    func textFieldStyled() -> some View {
        self.modifier(TextFieldStyleViewModifier())
    }
}
