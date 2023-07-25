//
//  MortgageView.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/23/23.
//

import SwiftUI

struct MortgageView: View {
    
    // form fields
    @State var loanAmountValueText = ""
    @State var payment = ""
    @State var interestRate = ""
    @State var noOfYears = ""
    
    @State var data: [String] = []
    
    @FocusState var focussedField: FocusedField?
    
    enum FocusedField {
        case int, dec
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    TextField("Loan Amount", text: $loanAmountValueText)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .dec)
                        .numbersOnly($loanAmountValueText, includeDecimal: true)
                    
                    TextField("Interest", text: $interestRate)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .dec)
                        .numbersOnly($interestRate, includeDecimal: true)
                    
                    TextField("Payment", text: $payment)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .dec)
                        .numbersOnly($payment, includeDecimal: true)
                    
                    TextField("No. of Years", text: $noOfYears)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .dec)
                        .numbersOnly($noOfYears, includeDecimal: true)
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Calculate".uppercased())
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.cornerRadius(10))
                            .foregroundColor(.white)
                            .font(.headline)
                    })
                    Spacer()
                }
            }
            .padding(30)
            .navigationTitle("Mortgage")
            // enable hiding the keyboard
            .toolbar{
                ToolbarItem(placement: .keyboard) {
                    Spacer()
                }
                ToolbarItem(placement: .keyboard) {
                    Button{
                        focussedField = nil
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
            .onAppear{
                UITextField.appearance().clearButtonMode = .whileEditing
            }}
    }
}

struct MortgageView_Previews: PreviewProvider {
    static var previews: some View {
        MortgageView()
    }
}
