//
//  SavingView.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/23/23.
//

import SwiftUI

struct SavingView: View {
    
    enum FocusedField {
        case int, dec
    }
    
    // form fields
    @State var presentValueText = ""
    @State var futureValueText = ""
    @State var interestRate = ""
    @State var noOfPayments = ""
    @State var payment = ""
    @State var noOfCompounds = ""
    
    @State var data: [String] = []
    
    @FocusState var focussedField: FocusedField?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TextField("Present Value", text:$presentValueText)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .int)
                        .numbersOnly($presentValueText)
                    
                    TextField("Future Value", text:$futureValueText)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .dec)
                        .numbersOnly($futureValueText, includeDecimal: true)
                    
                    TextField("Interest", text: $interestRate)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .dec)
                        .numbersOnly($interestRate, includeDecimal: true)
                    
                    TextField("Payment", text:$payment)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .int)
                        .numbersOnly($payment)
                    
                    TextField("No. of Payments Per Year", text:$noOfPayments)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .dec)
                        .numbersOnly($noOfPayments, includeDecimal: true)
                    
                    TextField("No. of Compounds Per Year", text: $noOfCompounds)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .dec)
                        .numbersOnly($noOfCompounds, includeDecimal: true)
                    
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
                }            }
            .padding(30)
            .navigationTitle("Savings")
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
            }
        }
    }
    
    func calculate() {
        
    }
}

struct SavingView_Previews: PreviewProvider {
    static var previews: some View {
        SavingView()
    }
}
