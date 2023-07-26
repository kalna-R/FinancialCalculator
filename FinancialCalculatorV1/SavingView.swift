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
    @State private var presentValueText = ""
    @State private var futureValueText = ""
    @State private var interestRate = ""
    @State private var noOfPayments = ""
    @State private var payment = ""
    @State private var noOfCompounds = ""
    @State private var isCompoundSaving = false
    
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
                    
                    TextField("Interest Rate %", text: $interestRate)
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
                    
                    Toggle(isOn: $isCompoundSaving, label: {
                        Text("Compound Saving")
                            .foregroundColor(Color.black.opacity(0.5))
                    }
                    )
                    .padding()
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    
                    Button(action: {
                        // call calculation method
                        calculate()
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
    
    private func calculate() {
        // get all empty fields
        let emptyInputFields = [presentValueText, futureValueText, interestRate, payment, noOfPayments]
            .filter{ $0.isEmpty }
        
        // define which formular to call for each input
        if (emptyInputFields.count > 1) {
            // show error - fill required fields
        }
        if(emptyInputFields.count == 0) {
            // show error - leave one field empty
        }
        //if(emptyInputFields.count == 1){
            // get calculation method
            calculationMethod()
        //}
    }
    
    private func calculationMethod() {
        if (presentValueText.isEmpty){
            calculatePresentValue()
        }
        if (futureValueText.isEmpty){
            calculateFututrValue()
        }
        if (interestRate.isEmpty){
            calculateInterest()
        }
        if (payment.isEmpty){
            calculatePayment()
        }
        if (noOfPayments.isEmpty){
            noOfPayments = String(format: "%.2f", calculateNoOfPayments())
            print(noOfPayments)
        }
    }
    
    // calculate
    
    private func calculatePresentValue(){
            
    }
    
    private func calculateFututrValue(){
        
    }
    
    private func calculateInterest(){
        
       

    }
    
    private func calculatePayment(){
        
    }
    
    
    // todo
    private func calculateNoOfPayments() -> Double {
        guard let pv = Double(presentValueText),
              let i = Double(interestRate),
              let pmt = Double(payment)
        else {
            return 0.0
        }
        
        let interestPerMonth = i / 12
        let numerator = pmt / interestPerMonth
        let denominator = numerator - pv
        let numberOfPayments = log(numerator / denominator) / log(1 + interestPerMonth)
        
        return numberOfPayments
    }
    
    struct LoanView_Previews: PreviewProvider {
        static var previews: some View {
            LoanView()
        }
    }
}

struct SavingView_Previews: PreviewProvider {
    static var previews: some View {
        SavingView()
    }
}
