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

    func saveCheckInDate(_ date: Date, forCompany companyName: String) {
        let context = persistentContainer.viewContext

        if !date.isValidDateTime() {
            print("Datetime is invalid (in the future), not saving.")
            return
        }

        // Fetch or create the Company
        let companyFetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        companyFetchRequest.predicate = NSPredicate(format: "name == %@", companyName)

        var company: Company
        do {
            if let fetchedCompany = try context.fetch(companyFetchRequest).first {
                company = fetchedCompany
            } else {
                company = Company(context: context)
                company.name = companyName
                company.createdAt = Date()
            }
        } catch {
            print("Failed to fetch or create company: \(error)")
            return
        }

        // Create the Employee object and set its check-in date and company
        let employee = Employee(context: context)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        employee.check_in_date_time = formatter.string(from: date)
        employee.company = company  // Set the company

        do {
            try context.save()
            print("Check-in date saved successfully for company \(companyName)")
        } catch {
            print("Failed to save: \(error)")
        }
    }

    @objc func fetchCompanyName() -> String? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        
        // Sort the fetch request to get the most recent company
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        fetchRequest.fetchLimit = 1

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
    
    @objc func fetchInitialDate() -> Date {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "check_in_date_time", ascending: false)]
        fetchRequest.fetchLimit = 1

        do {
            let result = try context.fetch(fetchRequest).first
            if let dateString = result?.check_in_date_time {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                return formatter.date(from: dateString) ?? Date().fetchValidDateWithMockedHourMinute()
            }
        } catch {
            print("Fetch failed: \(error)")
        }
        return Date().fetchValidDateWithMockedHourMinute()
    }

}
