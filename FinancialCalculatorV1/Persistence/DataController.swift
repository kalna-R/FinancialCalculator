//
//  DataController.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/30/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CalculateModel")
    
    init() {
        container.loadPersistentStores { descrption, error in
            if let error = error {
                print("Failed to load core date: \(error.localizedDescription)")
            }
        }

    }
}
