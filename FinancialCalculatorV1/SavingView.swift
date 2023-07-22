//
//  SavingView.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/23/23.
//

import SwiftUI

struct SavingView: View {
    
    @State var presentValueText: String = ""
    @State var data: [String] = []
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Present Value", text:$presentValueText)
                    .padding()
                    .background(Color.gray.opacity(0.2).cornerRadius(10))
                    .foregroundColor(.black)
                    .font(.headline)
                
                TextField("Present Value", text:$presentValueText)
                    .padding()
                    .background(Color.gray.opacity(0.2).cornerRadius(10))
                    .foregroundColor(.black)
                    .font(.headline)
                
                TextField("Present Value", text:$presentValueText)
                    .padding()
                    .background(Color.gray.opacity(0.2).cornerRadius(10))
                    .foregroundColor(.black)
                    .font(.headline)
                
                TextField("Present Value", text:$presentValueText)
                    .padding()
                    .background(Color.gray.opacity(0.2).cornerRadius(10))
                    .foregroundColor(.black)
                    .font(.headline)
                
                TextField("Present Value", text:$presentValueText)
                    .padding()
                    .background(Color.gray.opacity(0.2).cornerRadius(10))
                    .foregroundColor(.black)
                    .font(.headline)
                
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
            .padding(30)
            .navigationTitle("Savings")
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
