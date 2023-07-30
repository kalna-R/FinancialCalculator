//
//  HistoryLSubView.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/30/23.
//

import SwiftUI

struct HistorySSubView: View {
    
    // access managed object context
    @Environment(\.managedObjectContext) var moc
    
    // read data from database
    @FetchRequest(sortDescriptors: []) var fetchRequest: FetchedResults<CalculationSaving>
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    Text("Savings")
                    Form{
                        List(fetchRequest, id: \.id) {calculate in
                            Section(header: Text("Result")) {
                                HStack {
                                    Text("Principal").padding(.leading)
                                    Spacer()
                                    Text(String(calculate.principal)).padding(.trailing)
                                }
                                HStack {
                                    Text("Future Value").padding(.leading)
                                    Spacer()
                                    Text(String(calculate.fututeValue)).padding(.trailing)
                                }
                                HStack {
                                    Text("Interest Rate").padding(.leading)
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
        }
    }
}
