//
//  ListView.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/30/23.
//

/*import SwiftUI

struct ListView: View {
    
    // access managed object context
    @Environment(\.managedObjectContext) var moc
   
    // read data from database
    @FetchRequest var fetchRequestM: FetchedResults<Calculation>
    
    @Binding var filter : String
    
    init(filter: Binding<String>) {
        _filter = filter
        //_fetchRequestM = FetchRequest<Calculation>(sortDescriptors: [], predicate: NSPredicate(format: "calcType = %@", filter.wrappedValue))
    }
    
    var body: some View {
        VStack{
            if filter == "Savings"{
                Form{
                    List(fetchRequestM, id: \.id) {calculate in
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
            if filter == "Loan" {
                type = "Loan"
            }
            if filter == "Mortgage"{
                List(fetchRequestM) {calculate in
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

/*struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(filter: "Savings")
    }
}*/

*/
