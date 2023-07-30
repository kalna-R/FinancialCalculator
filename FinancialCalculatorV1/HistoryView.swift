//
//  HistoryView.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/29/23.
//

import SwiftUI

struct HistoryView: View {
    
    // access managed object context
     @Environment(\.managedObjectContext) var moc
    
    // read data from database
    //@FetchRequest var fetchRequestM: FetchedResults<Calculation>

    //filter value
    @State var calcType:String = "Savings"
    
    let types = ["Savings", "Loan", "Mortgage"]
    
    var body: some View {
        NavigationView {
            List{
                NavigationLink(destination: HistorySSubView()){
                    Text("Savings")
                }.onTapGesture {
                    self.calcType = "Savings"
                }
                NavigationLink(destination: HistorySubView()){
                    Text("Loan")
                }.onTapGesture {
                    self.calcType = "Loan"
                }
                NavigationLink(destination: HistorySubView()){
                    Text("Mortgage")
                }
                .onTapGesture {
                    self.calcType = "Mortgage"
                }
                
            }
            .navigationTitle("History")
        }
    }
}

/*struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}*/


