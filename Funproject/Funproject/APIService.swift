//
//  MockAPIService.swift
//  Funproject
//
//  Created by Stig von der Ahé on 02/10/2024.
//

import Foundation

//Note:
// Dependency Inversion Principle DateTimePickerView depends on the CoreDataManager for data operations and MockAPIService for the mock API call. This abstracts the data source from the UI layer.
class APIService {
    
    static let shared = APIService()
    
    private init() {}
    
    // Mock API call to get initial check-in time
    func fetchInitialDateTime(completion: @escaping (String) -> Void) {
        // Simulate a network delay
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            // Mock JSON response: {"dateTime": "2024-10-02 06:30"}
            let mockResponse = "{\"dateTime\": \"2024-10-02 06:30\"}"
            
            // Parse the mock response
            if let data = mockResponse.data(using: .utf8) {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String],
                       let dateTime = json["dateTime"] {
                        DispatchQueue.main.async {
                            completion(dateTime)
                        }
                    }
                } catch {
                    print("Failed to parse mock API response.")
                    DispatchQueue.main.async {
                        completion("") // Return an empty string on error
                    }
                }
            }
        }
    }
}
