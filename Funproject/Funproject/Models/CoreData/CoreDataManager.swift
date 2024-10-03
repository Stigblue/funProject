//
//  CoreDataManager.swift
//  Funproject
//
//  Created by Stig von der Ahé on 02/10/2024.
//

import Foundation
import CoreData


@objc class CoreDataManager: NSObject {
    @objc static let shared = CoreDataManager()
    
    public override init() {}
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Funproject")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveCheckInDate(_ date: Date, forCompany companyName: String) {
        logAllCheckInEntries()
        guard date.isValidDateTime() else {
            print("Datetime is invalid (in the future), not saving.")
            return
        }
        
        guard let company = saveCompanyName(companyName) else {
            print("Company is nil, cannot save check-in date.")
            return
        }
        
        saveEmployeeCheckInDate(date, forCompany: company)
    }
    
    func logAllCheckInEntries() {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()

        do {
            let entries = try context.fetch(fetchRequest)
            for entry in entries {
                print("Entry: \(entry.check_in_date_time ?? "No Date")")
            }
        } catch {
            print("Failed to fetch entries: \(error)")
        }
    }
    
    private func saveCompanyName(_ companyName: String) -> Company? {
        let context = persistentContainer.viewContext
        let companyFetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        companyFetchRequest.predicate = NSPredicate(format: "name == %@", companyName)
        
        do {
            
            if let fetchedCompany = try context.fetch(companyFetchRequest).first {
                return fetchedCompany
            } else {
                let newCompany = Company(context: context)
                newCompany.name = companyName
                newCompany.createdAt = Date()
                try context.save()
                return newCompany
            }
        } catch {
            print("Failed to fetch or create company: \(error)")
            return nil
        }
    }
    
    private func saveEmployeeCheckInDate(_ date: Date, forCompany company: Company) {
        let context = persistentContainer.viewContext
        let employee = Employee(context: context)
  
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        employee.check_in_date_time = formatter.string(from: date)
        employee.company = company
        employee.createdAt = Date()

        do {
            try context.save()
            print("Check-in date saved successfully for company \(company.name ?? "Unknown Company") at \(employee.check_in_date_time ?? "Unknown Date")")
        } catch {
            print("Failed to save employee check-in date: \(error.localizedDescription)")
        }
    }
    
    @objc func fetchCompanyName() -> String? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        
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
    
    @objc func fetchInitialDate(completion: @escaping (Date) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let context = self.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
   
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)] 
            fetchRequest.fetchLimit = 1

            do {
                let result = try context.fetch(fetchRequest).first
                
                if let employee = result {
                    if let dateString = employee.check_in_date_time {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd HH:mm"
                        
                        if let fetchedDate = formatter.date(from: dateString) {
                            print("Fetched check-in date: \(fetchedDate)")
                            completion(fetchedDate)
                            return
                        } else {
                            print("Failed to convert date string: \(dateString) to Date")
                        }
                    } else {
                        print("Check-in date string is nil.")
                    }
                } else {
                    print("No check-in date found.")
                }
            } catch {
                print("Fetch failed: \(error.localizedDescription)")
            }

            let mockedDate = Date().fetchValidDateWithMockedHourMinute()
            print("Returning mocked date: \(mockedDate)")
            completion(mockedDate)
        }
    }
}
