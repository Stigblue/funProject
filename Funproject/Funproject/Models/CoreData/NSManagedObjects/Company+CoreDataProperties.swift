//
//  Company+CoreDataProperties.swift
//  Funproject
//
//  Created by Stig von der Ahé on 03/10/2024.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var employees: Employee?

}
