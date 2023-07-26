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
                Text("Leave blank the field you want to \n calculate")
                    .aspectRatio(contentMode: ContentMode.fit)
                    .multilineTextAlignment(.center)
                    .scaledToFit()
                    .padding()
                
                Text("Click on View tab to see your \n history of calclations")
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .cornerRadius(20)
                    .padding()
            
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 300)
            .background(Rectangle().fill(Color.cyan))
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
