//
//  CalculationSaving+CoreDataProperties.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/30/23.
//
//

import Foundation
import CoreData


extension CalculationSaving {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CalculationSaving> {
        return NSFetchRequest<CalculationSaving>(entityName: "CalculationSaving")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var principal: Double
    @NSManaged public var fututeValue: Double
    @NSManaged public var intRate: Double
    @NSManaged public var payment: Double
    @NSManaged public var calcType: String?

}

extension CalculationSaving : Identifiable {

}
