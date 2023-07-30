//
//  FinancialCalculatorV1App.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/22/23.
//

import SwiftUI

@main
struct FinancialCalculatorV1App: App {
    
    // inject core data
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
