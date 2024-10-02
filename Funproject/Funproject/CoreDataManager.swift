//
//  CoreDataManager.swift
//  Funproject
//
//  Created by Stig von der Ahé on 02/10/2024.
//

import Foundation
import CoreData

// Note:
// Interface Segregation Principle: The CoreDataManager class handles all CoreData operations, keeping CoreData logic segregated from the UI.
@objc class CoreDataManager: NSObject {
    @objc static let shared = CoreDataManager()

    public override init() {}

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Funproject") // Use your actual .xcdatamodeld name
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func saveCheckInDate(_ date: Date) {
        let context = persistentContainer.viewContext
        
        if !date.isValidDateTime(selectedDate: date) {
            print("Datetime is invalid (in the future), not saving.")
            return
        }
        
        let employee = Employee(context: context)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        employee.check_in_date_time = formatter.string(from: date)

        do {
            try context.save()
            print("Check-in date saved successfully")
        } catch {
            print("Failed to save: \(error)")
        }
    }

    @objc func fetchCompanyName() -> String? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        
        do {
            let companies = try context.fetch(fetchRequest)
            if let company = companies.first {
                return company.name
            }
        } catch {
            print("Failed to fetch company: \(error)")
        }
        return nil
    }
}
