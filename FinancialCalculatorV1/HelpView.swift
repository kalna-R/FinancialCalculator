//
//  HelpView.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/23/23.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        
        VStack {
            TabView{
                VStack {
                    Text("Overview").fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.leading)
                    Text("The Financial Calculator is a powerful tool developed to assist you with accurate calculations for savings, loans and mortgages.")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                    .padding()
                }
                
                VStack {
                    Text("Getting Started").fontWeight(.bold).foregroundColor(.white)
                    Text("1. Choose the type of calculation you want to perform: mortgage, loan, or savings. \n 2. Input the relevant information into the corresponding fields.\n 3. Ensure that one field is left blank to obtain the result.")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding()
                }
                
                VStack {
                    Text("Example").fontWeight(.bold).foregroundColor(.white)
                    Text("To calculate the Mortgage Amount, fill in the Loan Term, Interest Rate, and Monthly Payment fields, and leave the Mortgage Amount field blank. Press 'Calculate' to obtain the result.")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding()
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 300)
            .background(Rectangle().fill(Color.blue.opacity(0.6)))
            .cornerRadius(20)
        }
        .padding()
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}

