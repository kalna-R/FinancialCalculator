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
    @AppStorage("SPRINCIPAL") private var presentValueText = ""
    @AppStorage("SFUTURE") private var futureValueText = ""
    @AppStorage("SINTRATE") private var interestRate = ""
    @AppStorage("SNOPMTS") private var noOfPayments = ""
    @AppStorage("SPMT") private var payment = ""
    @AppStorage("SNOCOMPOUNDS") private var noOfCompounds = ""
    @AppStorage("ISEND") private var isAtEnd = false
    
    // enable/disable regular contributions
    @AppStorage("ISON") private var isOn = true
    
    // validate data array
    @State var data: [String] = []
    
    // handle errors
    @State private var isAlertVisible = false
    @State private var emptyFiledsError: String? = nil
    
    @FocusState var focussedField: FocusedField?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .leading) {
                    Group{
                        Text("Principal Amount")
                            .font(.headline)
                            .foregroundColor(Color.black.opacity(0.8))
                        TextField("Present Value", text:$presentValueText)
                            .modifier(TextFieldStyleViewModifier())
                            .focused($focussedField, equals: .dec)
                            .numbersOnly($presentValueText, includeDecimal: true)
                        
                        Text("Future Value")
                            .font(.headline)
                            .foregroundColor(Color.black.opacity(0.8))
                        TextField("Future Value", text:$futureValueText)
                            .modifier(TextFieldStyleViewModifier())
                            .focused($focussedField, equals: .dec)
                            .numbersOnly($futureValueText, includeDecimal: true)
                        
                        Text("Annual Interest Rate %")
                            .font(.headline)
                            .foregroundColor(Color.black.opacity(0.8))
                        TextField("Interest Rate", text: $interestRate)
                            .modifier(TextFieldStyleViewModifier())
                            .focused($focussedField, equals: .dec)
                            .numbersOnly($interestRate, includeDecimal: true)
                        
                        Text("Time Period (months)")
                            .font(.headline)
                            .foregroundColor(Color.black.opacity(0.8))
                        TextField("Time", text:$noOfPayments)
                            .modifier(TextFieldStyleViewModifier())
                            .focused($focussedField, equals: .int)
                            .numbersOnly($noOfPayments)
                    }
                    
                    Toggle(isOn: $isOn, label: {
                        Text("Regular Contributions")
                            .foregroundColor(Color.black.opacity(0.5))
                    }
                    )
                    .padding()
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                           
                    Group{
                        Text("Monthly Payment")
                            .font(.headline)
                            .foregroundColor(Color.black.opacity(0.8))
                        TextField("Monthly Payment", text:$payment)
                            .modifier(TextFieldStyleViewModifier())
                            .focused($focussedField, equals: .dec)
                            .disabled(!isOn)
                        
                        Toggle(isOn: $isAtEnd, label: {
                            Text("Deposit at the end of month")
                                .foregroundColor(Color.black.opacity(0.5))
                        }
                        ).disabled(!isOn)
                        .padding()
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                    }
                    
                    Button(action: {
                        
                        if (isOn) {
                            // if all fields are valid for series calc, then calculate
                            let isError = !validateInputSeries()
                            if isError {
                                isAlertVisible = true
                            } else {
                                let A = calculateFututrValueSeries()
                                self.futureValueText = String(format: "%2f", A)                            }
                        }
                        else {
                            // if all fields are valid, then calculate
                            let isError = !validateInput()
                            if isError {
                                isAlertVisible = true
                            } else {
                                calculationMethod()
                            }
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
    
    private func validateInput() -> Bool {
        var isValid = true
        
        // get all empty fields
        let emptyInputFields = [presentValueText, interestRate, noOfPayments, futureValueText]
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
    
    private func validateInputSeries() -> Bool {
        var isValid = true
        
        // get all empty fields
        let emptyInputFields = [presentValueText, interestRate, noOfPayments, futureValueText, payment]
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
        if (futureValueText.isEmpty){
            let amount = calculateFututrValue()
            self.futureValueText = String(format: "%2f", amount)
        }
        if (interestRate.isEmpty){
            let intRate = calculateInterest()
            self.interestRate = String(format: "%2f", intRate)
        }
        if (noOfPayments.isEmpty){
            let pmt = calculateNoOfPayments()
            self.noOfPayments = String(Int(pmt.rounded()))
        }
    }
    
    // calculate principal amount
    private func calculatePresentValue() -> Double{
        let A = Double(futureValueText) ?? 0
        let r = Double(interestRate) ?? 0
        let t = Double(noOfPayments) ?? 0 // months
        let n = 12.00 // monthly for this cw
        
        let i = r / 100
        
        let denominator = pow((1 + (i/n)), n * t)
        return A / denominator
    }
    
    // calculate future value including interest
    private func calculateFututrValue() -> Double {
        let r = Double(interestRate) ?? 0
        let p = Double(presentValueText) ?? 0
        let n = 12.00
        let t = Double(noOfPayments) ?? 0
        
        let i = r / 100
        
        return p * (pow((1 + i / n ), n * t))
    }

    // calculate interest
    private func calculateInterest() -> Double {
        let a = Double(futureValueText) ?? 0
        let p = Double(presentValueText) ?? 0
        let n = 12.00
        let t = Double(noOfPayments) ?? 0
        
        let x = pow((a / p), 1/(n * t))
        
        return n * (x - 1) * 100
    }
    
    // calc time period in months
    private func calculateNoOfPayments() -> Double {
        let a = Double(futureValueText) ?? 0
        let p = Double(presentValueText) ?? 0
        let n = 12.00
        let r = Double(interestRate) ?? 0
    
        let i = r / 100
        
        let numerator = log(a / p)
        let denominator = n * (log(1 + i / n))
        
        return numerator / denominator
    }
    
    // calculate future value including interest for series
    private func calculateFututrValueSeries() -> Double {
        let r = Double(interestRate) ?? 0
        let p = Double(presentValueText) ?? 0
        let pmt = Double(payment) ?? 0
        let n = 12.00
        let t = Double(noOfPayments) ?? 0 //months
        let isEnd = isAtEnd
        
        let i = r / 100
        
        var futureValueSeries = 0.0
        
        if(!isEnd) {
            let numerator = (pow(1 + i / n, n * t) - 1)
            let denominator = i / n
            futureValueSeries = pmt * (numerator / denominator) * (1 + i / n)
        } else {
            
            let r = r / 100.0
            let n = 12.0
            
            futureValueSeries = pmt * ((pow(1 + r / n, n * t) - 1) * (n / r)) * (1 + r / n)
            
            /*let numerator = pow(1 + (i / n), n * t) - 1
             let denominator = i / n
             futureValueSeries = pmt * (numerator / denominator)*/
        }
        
        return futureValueSeries
    }
}

struct SavingView_Previews: PreviewProvider {
    static var previews: some View {
        SavingView()
    }
}
