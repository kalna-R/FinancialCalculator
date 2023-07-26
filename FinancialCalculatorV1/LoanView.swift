//
//  LoanView.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/23/23.
//

import SwiftUI

struct LoanView: View {
    
    // form fields
    @State var presentValueText = ""
    @State var futureValueText = ""
    @State var interestRate = ""
    @State var noOfPayments = ""
    @State var payment = ""
    
    @State var data: [String] = []
    
    @FocusState var focussedField: FocusedField?
    
    enum FocusedField {
        case int, dec
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TextField("Loan Amount", text:$presentValueText)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .int)
                        .numbersOnly($presentValueText)
                    
                    TextField("Future Value", text:$futureValueText)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .dec)
                        .numbersOnly($futureValueText, includeDecimal: true)
                    
                    TextField("Interest Rate (%)", text: $interestRate)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .dec)
                        .numbersOnly($interestRate, includeDecimal: true)
                    
                    TextField("Monthly Payment", text:$payment)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .int)
                        .numbersOnly($payment)
                    
                    TextField("No. of Payments", text:$noOfPayments)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .dec)
                        .numbersOnly($noOfPayments, includeDecimal: true)
                    
                    Button(action: {
                        // calculate
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
                }
                
            }
            .padding(30)
            .navigationTitle("Loans")
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
