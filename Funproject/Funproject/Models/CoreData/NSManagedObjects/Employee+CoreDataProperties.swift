//
//  Employee+CoreDataProperties.swift
//  Funproject
//
//  Created by Stig von der Ahé on 03/10/2024.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var check_in_date_time: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var company: Company?

}
