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
                ContentView()
                    .tabItem{
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                
                SavingView()
                    .tabItem{
                        Image(systemName: "dollarsign")
                        Text("Savings")
                    }
                    .tag(1)
                
                LoanView()
                    .tabItem{
                        Image(systemName: "banknote.fill")
                        Text("Loans")
                    }
                    .tag(2)
                
                MortgageView()
                    .tabItem{
                        Image(systemName: "house.lodge")
                        Text("Mortgage")
                    }
                    .tag(3)
                
                HelpView()
                    .tabItem{
                        Image(systemName: "list.bullet.rectangle")
                        Text("History")
                    }
                    .tag(4)
            }
    }
}

struct TabViewHelper_Previews: PreviewProvider {
    static var previews: some View {
        TabViewHelper()
    }
}
