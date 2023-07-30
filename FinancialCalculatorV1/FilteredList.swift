//
//  FilteredList.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/30/23.
//

/*import SwiftUI

struct FilteredList: View {
    
    // access managed object context
    //@Environment(\.managedObjectContext) var moc
    
    // read data from database
    @FetchRequest var fetchRequest: FetchedResults<Calculation>
    
    init(filter: String) {
       _fetchRequest = FetchRequest<Calculation>(sortDescriptors: [], predicate: NSPredicate(format: "type = %@", filter))
    }
    
    var body: some View {
        Form{
            List(fetchRequest) {calculate in
                Section(header: Text("first")) {
                    HStack {
                        Text("Principal").padding(.leading)
                        Spacer()
                        Text(String(calculate.principal)).padding(.trailing)
                    }
                    HStack {
                        Text("Future Value").padding(.leading)
                        Spacer()
                        Text(String(calculate.futureValue)).padding(.trailing)
                    }
                    HStack {
                        Text("Interest Rat").padding(.leading)
                        Spacer()
                        Text(String(calculate.intRate)).padding(.trailing)
                    }
                    HStack {
                        Text("Payment").padding(.leading)
                        Spacer()
                        Text(String(calculate.payment)).padding(.trailing)
                    }
                }
            }
        }
        
    }
}
*/

