//
//  AmortizationDataView.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/30/23.
//

import SwiftUI

struct AmortizationDataView: View {
    
    @AppStorage("SPRINCIPAL") private var presentValueText = ""
    @AppStorage("SFUTURE") private var futureValueText = ""
    @AppStorage("SINTRATE") private var interestRate = ""
    @AppStorage("SNOPMTS") private var noOfPayments = ""
    @AppStorage("SPMT") private var payment = ""
    @AppStorage("SNOCOMPOUNDS") private var noOfCompounds = ""
    
    var body: some View {
        Form{
            ForEach(1..<13 , id:\.self) { i in
                let value = calculateData(nopmts: i)
                
                Section(header: Text("Month " + String(i))) {
                    HStack {
                        Text("Interest Rate").padding(.leading)
                        Spacer()
                        Text(String(interestRate) + "%").padding(.trailing)
                    }
                    HStack {
                        Text("Principal").padding(.leading)
                        Spacer()
                        Text(presentValueText).padding(.trailing)
                    }
                    HStack {
                        Text("Future Value").padding(.leading)
                        Spacer()
                        Text("\(value, specifier: "%.2f")").padding(.trailing)
                    }
                }
            }
        }.padding([.top], -5)
    }
    
    func calculateData(nopmts: Int) -> Double {
        let present = Double(presentValueText) ?? 0
        let intRate = Double(interestRate) ?? 0
        
        let r = (Double(intRate) / 100.0) / 12
        let n = 1.0
        let t = Double(nopmts)
        let f = present * pow(1 + r / n, n * t)
        
        return f

    }
    
}

struct AmortizationDataView_Previews: PreviewProvider {
    static var previews: some View {
        AmortizationDataView()
    }
}

