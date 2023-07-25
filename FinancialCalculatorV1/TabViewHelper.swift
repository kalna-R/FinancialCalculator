//
//  TabViewHelper.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/23/23.
//

import SwiftUI

struct TabViewHelper: View {
    var body: some View {
        TabView {
            
            SavingView()
                .tabItem{
                    Image(systemName: "dollarsign")
                    Text("Savings")
                }
            
            LoanView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Loans")
                }
            
            MortgageView()
                .tabItem{
                    Image(systemName: "banknote")
                    Text("Mortgage")
                }
            
            HelpView()
                .tabItem{
                    Image(systemName: "list.bullet.rectangle")
                    Text("View")
                }
        }
    }
}

struct TabViewHelper_Previews: PreviewProvider {
    static var previews: some View {
        TabViewHelper()
    }
}
