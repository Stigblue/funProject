import Foundation
import CoreData

@objc class EmployeeService: NSObject {
    let coreDataService = CoreDataService.shared
    
    // Testing commit
   @objc func saveCheckInDate(_ date: Date, forCompany companyName: String) {
        guard date.isNotFuture() else {
            print("Datetime is invalid (in the future), not saving.")
            return
        }
        
        guard let company = CompanyService().fetchOrCreateCompany(with: companyName) else {
            print("Company is nil, cannot save check-in date.")
            return
        }
        
        let context = coreDataService.persistentContainer.viewContext
        let employee = Employee(context: context)
        employee.check_in_date_time = DateFormatterService().string(from: date)
        employee.createdAt = Date()
        employee.company = company
        coreDataService.saveContext()
    }
    
   @objc func fetchMostRecentCheckInDate(completion: @escaping (Date) -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let employee = self.coreDataService.fetchEntities(Employee.self, sortBy: "check_in_date_time", limit: 1)?.last,
               let dateString = employee.check_in_date_time {
                if let date = DateFormatterService().date(from: dateString) {
                    completion(date)
                } else {
                    completion(Date().fetchValidDateWithMockedHourMinute())
                }
            } else {
                completion(Date().fetchValidDateWithMockedHourMinute())
            }
        }
    }
}
