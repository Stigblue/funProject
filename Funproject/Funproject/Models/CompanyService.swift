import Foundation
import CoreData

@objc class CompanyService: NSObject {
    let coreDataService = CoreDataService.shared
    
    @objc func fetchOrCreateCompany(with name: String) -> Company? {
        let context = coreDataService.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            if let fetchedCompany = try context.fetch(fetchRequest).first {
                return fetchedCompany
            } else {
                let newCompany = Company(context: context)
                newCompany.name = name
                newCompany.createdAt = Date()
                coreDataService.saveContext()
                return newCompany
            }
        } catch {
            print("Failed to fetch or create company: \(error)")
            return nil
        }
    }
    
   @objc func fetchMostRecentCompanyName() -> String? {
        return coreDataService.fetchEntities(Company.self, sortBy: "createdAt", limit: 1)?.first?.name
    }
}
