//
//  Expense+CoreDataProperties.swift
//  TheNewBegining2.0storyBoard
//
//  Created by Егор Родионов on 30.06.22.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var name: String?
    @NSManaged public var amount: Int64

}

extension Expense : Identifiable {

}
