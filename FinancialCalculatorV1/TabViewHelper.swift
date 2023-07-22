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
                    Image(systemName: "savings")
                    Text("Savings")
                }
        }
    }
}

struct TabViewHelper_Previews: PreviewProvider {
    static var previews: some View {
        TabViewHelper()
    }
}
