//
//  LoanView.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/23/23.
//

import SwiftUI

struct LoanView: View {
    
    // form fields
    @AppStorage("LPRINCIPAL") var presentValueText = ""
    @AppStorage("LINT") var interestRate = ""
    @AppStorage("LNPMT") var noOfPayments = ""
    @AppStorage("LPMT") var payment = ""
    
    // handle errors
    @State private var isAlertVisible = false
    @State private var emptyFiledsError: String? = nil
    
    @State var data: [String] = []
    
    @FocusState var focussedField: FocusedField?
    
    enum FocusedField {
        case int, dec
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading){
                    Group{
                        Text("Principal Amount")
                            .font(.headline)
                            .foregroundColor(Color.black.opacity(0.8))
                        TextField("Loan Amount", text:$presentValueText)
                            .modifier(TextFieldStyleViewModifier())
                            .focused($focussedField, equals: .dec)
                            .numbersOnly($presentValueText, includeDecimal: true)
                                                
                        Text("Interest Rate")
                            .font(.headline)
                            .foregroundColor(Color.black.opacity(0.8))
                        TextField("Interest Rate (%)", text: $interestRate)
                            .modifier(TextFieldStyleViewModifier())
                            .focused($focussedField, equals: .dec)
                            .numbersOnly($interestRate, includeDecimal: true)
                    }
                    
                    Group{
                        Text("Monthly Payment")
                            .font(.headline)
                            .foregroundColor(Color.black.opacity(0.8))
                        TextField("Monthly Payment", text:$payment)
                            .modifier(TextFieldStyleViewModifier())
                            .focused($focussedField, equals: .dec)
                            .numbersOnly($payment, includeDecimal: true)
                        
                        Text("No.of Payments")
                            .font(.headline)
                            .foregroundColor(Color.black.opacity(0.8))
                        TextField("Months", text:$noOfPayments)
                            .modifier(TextFieldStyleViewModifier())
                            .focused($focussedField, equals: .dec)
                            .numbersOnly($noOfPayments, includeDecimal: true)
                    }
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
    
    private func validateInput() -> Bool {
        var isValid = true
        
        // get all empty fields
        let emptyInputFields = [presentValueText, interestRate, payment, noOfPayments]
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
       if (presentValueText.isEmpty){
            let principal = calculatePresentValue()
            self.presentValueText = String(format: "%2f", principal)
        }
        if (interestRate.isEmpty){
            let intRate = calculateInterest()
            self.interestRate = String(format: "%2f", intRate)
        }
        if (payment.isEmpty){
            let pmt = calculatePayment()
            self.payment = String(format: "%2f", pmt)
        }
        if (noOfPayments.isEmpty){
            let months = calculateNoOfPayments()
            self.noOfPayments = String(format: "%2f", months)
        }
    }
    
    
    // calculate loan amount
    private func calculatePresentValue() -> Double{
        let pmt = Double(payment) ?? 0
        let i = Double(interestRate) ?? 0
        let months = Double(noOfPayments) ?? 0
        
        let int = i / 12 / 100
        
        let a = (pmt / int)
        let b = 1 - (1 / (pow((1 + int), months)))
        
        return a * b
    }
    
    // calculate annual interest
    private func calculateInterest() -> Double{
        let principal = Double(presentValueText) ?? 0
        let pmt = Double(payment) ?? 0
        let noPMT = Double(noOfPayments) ?? 0

        let interestAmount = (pmt * noPMT) - principal
        
        let rate = (interestAmount / principal) / noPMT * 12 * 100
        
        return rate

    }
    
    // calculate monthly payment
    private func calculatePayment() -> Double{
        let principal = Double(presentValueText) ?? 0
        let int = Double(interestRate) ?? 0
        let noPMT = Double(noOfPayments) ?? 0
        
        //monthly interest
        let i = int / 100 / 12

        let numerator = principal * i * pow((1 + i), Double(noPMT))
        let denominator = pow((1 + i), Double(noPMT)) - 1
        
        return numerator / denominator
    }
    
    // calculate no of months
    private func calculateNoOfPayments() -> Double {
        let principal = Double(presentValueText) ?? 0
        let int = Double(interestRate) ?? 0
        let pmt = Double(payment) ?? 0
        
        //monthly interest
        let i = int / 12

        let numerator = log(1 + (i * principal) / pmt)
        let denominator = log(1 + i)
        
        return numerator / denominator
    }
    
    struct LoanView_Previews: PreviewProvider {
        static var previews: some View {
            LoanView()
        }
    }
}
