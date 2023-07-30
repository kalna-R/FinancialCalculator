//
//  Calculation+CoreDataProperties.swift
//  FinancialCalculatorV1
//
//  Created by user233619 on 7/30/23.
//
//

import Foundation
import CoreData


extension Calculation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Calculation> {
        return NSFetchRequest<Calculation>(entityName: "Calculation")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var calcType: String?
    @NSManaged public var intRate: Double
    @NSManaged public var futureValue: Double
    @NSManaged public var principal: Double
    @NSManaged public var payment: Double

}

extension Calculation : Identifiable {

}
