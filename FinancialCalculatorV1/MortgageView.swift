//
//  MortgageView.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/23/23.
//

import SwiftUI

struct MortgageView: View {
    
    // form fields
    @AppStorage("AMOUNT") private var loanAmountValueText = ""
    @AppStorage("PMT") private var payment = ""
    @AppStorage("INT") private var interestRate = ""
    @AppStorage("MNTHS") private var noOfPMT = ""
    
    // handle errors
    @State private var isAlertVisible = false
    @State private var emptyFiledsError: String? = nil
    
    @State var data: [String] = []
    
    @FocusState var focussedField: FocusedField?
    
    enum FocusedField {
        case int, dec
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack (alignment: .leading){
                    
                    Text("Principal Amount")
                        .font(.headline)
                        .foregroundColor(Color.black.opacity(0.8))
                    TextField("Amount", text: $loanAmountValueText)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .dec)
                        .numbersOnly($loanAmountValueText, includeDecimal: true)
                    
                    Text("Annual Interest Rate (%)")
                        .font(.headline)
                        .foregroundColor(Color.black.opacity(0.8))
                    TextField("Interest (%)", text: $interestRate)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .dec)
                        .numbersOnly($interestRate, includeDecimal: true)
                    
                    Text("Monthly Payment")
                        .font(.headline)
                        .foregroundColor(Color.black.opacity(0.8))
                    TextField("Payment", text: $payment)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .dec)
                        .numbersOnly($payment, includeDecimal: true)
                    
                    Text("No. of Months")
                        .font(.headline)
                        .foregroundColor(Color.black.opacity(0.8))
                    TextField("Months", text: $noOfPMT)
                        .modifier(TextFieldStyleViewModifier())
                        .focused($focussedField, equals: .dec)
                        .numbersOnly($noOfPMT, includeDecimal: true)
                    
                    Button(action: {
                        // if all fields are valid, then calculate
                        let isError = !validateInput()
                        if isError {
                            isAlertVisible = true
                        } else {
                          calculationMethod()
                        }
                    }, label: {
                        Text("Calculate".uppercased())
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.cornerRadius(10))
                            .foregroundColor(.white)
                            .font(.headline)
                    })
                    .alert(isPresented: $isAlertVisible) { // validate fields
                        Alert(title: Text("Error"),
                              message: Text(emptyFiledsError ?? "Error"),
                              dismissButton: .default(Text("OK")))
                    }
                    .padding()
                    
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
    
    private func validateInput() -> Bool {
        var isValid = true
        
        // get all empty fields
        let emptyInputFields = [loanAmountValueText, payment, interestRate, noOfPMT]
            .filter{ $0.isEmpty }
        
        // define which formular to call for each input
        if (emptyInputFields.count > 1) {
            // show error - fill required fields
            isValid = false
            emptyFiledsError = "Please fill all fields except one"
        }
        
        if(emptyInputFields.count == 0) {
            // show error - leave one field empty
            isValid = false
            emptyFiledsError = "Please leave one field blank to calculate"
        }
        return isValid
    }
    

    private func calculationMethod() {
        if (loanAmountValueText.isEmpty){
            let principal = calculatePrincipalValue()
            self.loanAmountValueText = String(format: "%2f", principal)
        }
        if (interestRate.isEmpty){
            let int = calculateInterest()
            self.interestRate = String(format: "%2f", int)
        }
        if (payment.isEmpty){
            let pmt = calculatePayment()
            self.payment = String(format: "%2f", pmt)
        }
        if (noOfPMT.isEmpty){
            let months = calculateNoOfPMT()
            self.noOfPMT = String(format: "%2f", months)
        }
    }
    
    // calculate pricipal amount
    private func calculatePrincipalValue() -> Double{
        let pmt = Double(payment) ?? 0
        let int = Double(interestRate) ?? 0
        let noOfPMT = Double(noOfPMT) ?? 0
        
        let i = int / 12 / 100
        
        return pmt * (1 - (1 / pow(1 + i, noOfPMT))) / i
    }
    
    // calculate annual interest rate
    private func calculateInterest() -> Double {
        let principal = Double(loanAmountValueText) ?? 0
        let pmt = Double(payment) ?? 0
        let noOfPMT = Double(noOfPMT) ?? 0
        
        return (1 - (1 / pow(1 + pmt / principal, noOfPMT / 12))) * 100
    }
    
    // calculate monthly ppayment
    private func calculatePayment() -> Double {
        let principal = Double(loanAmountValueText) ?? 0
        let int = Double(interestRate) ?? 0
        let noOfPMT = Double(noOfPMT) ?? 0
        
        return principal * (int / 12 / 100) / (1 - (1 / pow(1 + int / 12 / 100, noOfPMT)))
    }
    
    // calculate no of payments
    private func calculateNoOfPMT() -> Double {
        let principal = Double(loanAmountValueText) ?? 0
        let int = Double(interestRate) ?? 0
        let pmt = Double(payment) ?? 0
        
        return 12 * (1 - (1 / pow(1 + int / 100, principal / (pmt * 12))))
    }
}

struct MortgageView_Previews: PreviewProvider {
    static var previews: some View {
        MortgageView()
    }
}
