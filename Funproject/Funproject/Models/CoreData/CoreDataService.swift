import Foundation
import CoreData

@objc class CoreDataService: NSObject {
   @objc static let shared = CoreDataService()
    
    private override init() {}
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Funproject")
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // Fetch, Save, Delete operations related to Core Data
    func fetchEntities<T: NSManagedObject>(_ entityType: T.Type, sortBy key: String?, limit: Int = 0) -> [T]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityType))
        
        if let key = key {
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: key, ascending: false)]
        }
        
        if limit > 0 {
            fetchRequest.fetchLimit = limit
        }
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch \(entityType): \(error)")
            return nil
        }
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}
