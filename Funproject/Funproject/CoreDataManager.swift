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
class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "YourAppModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveCheckInDate(_ date: Date) {
        let context = persistentContainer.viewContext
        let employee = Employee(context: context)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        employee.check_in_date_time = formatter.string(from: date)
        
        do {
            try context.save()
        } catch {
            print("Failed to save: \(error)")
        }
    }
    
    func fetchInitialDate() -> Date {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "check_in_date_time", ascending: false)]
        fetchRequest.fetchLimit = 1
        
        do {
            let result = try context.fetch(fetchRequest).first
            if let dateString = result?.check_in_date_time {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                return formatter.date(from: dateString) ?? Date()
            }
        } catch {
            print("Fetch failed: \(error)")
        }
        return Date() // Fallback to current date
    }
}