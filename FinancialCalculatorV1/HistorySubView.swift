//
//  HistorySubView.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/30/23.
//

import SwiftUI

struct HistorySubView: View {
    
    // access managed object context
    @Environment(\.managedObjectContext) var moc
    
    // read data from database
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "self", ascending: false)]) var fetchRequestS: FetchedResults<Calculation>
    
    var body: some View {
        VStack{
            Text("Mortgage")
            Form{
                List(fetchRequestS, id: \.id) {calculate in
                    Section(header: Text("Result")) {
                        HStack {
                            Text("Principal").padding(.leading)
                            Spacer()
                            Text("\((calculate.principal), specifier: "%.2f")").padding(.trailing)
                        }
                        HStack {
                            Text("Interest Rate").padding(.leading)
                            Spacer()
                            Text("\((calculate.intRate), specifier: "%.2f") %").padding(.trailing)
                        }
                        HStack {
                            Text("Payment").padding(.leading)
                            Spacer()
                            Text("\((calculate.payment), specifier: "%.2f")").padding(.trailing)
                        }
                    }
                }
                
            }
        }.clipped()
    }
}
