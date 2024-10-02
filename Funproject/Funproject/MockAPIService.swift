//
//  MockAPIService.swift
//  Funproject
//
//  Created by Stig von der Ahé on 02/10/2024.
//

import Foundation

//Note:
// Dependency Inversion Principle DateTimePickerView depends on the CoreDataManager for data operations and MockAPIService for the mock API call. This abstracts the data source from the UI layer.
class MockAPIService {
    static func fetchInitialDate(completion: @escaping (Date) -> Void) {
        DispatchQueue.global().async {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let mockDateString = "2023-10-02 06:30"
            if let mockDate = formatter.date(from: mockDateString) {
                DispatchQueue.main.async {
                    completion(mockDate)
                }
            }
        }
    }
}
