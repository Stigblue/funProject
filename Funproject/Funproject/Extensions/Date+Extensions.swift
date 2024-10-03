//
//  Date+Extensions.swift
//  Funproject
//
//  Created by Stig von der Ahé on 02/10/2024.
//

import Swift
import Foundation

public extension Date {
    
    func fetchValidDateWithMockedHourMinute() -> Date {
        let mockedDate = fetchDateWithMockedHourMinute()
        return mockedDate.isValidDateTime() ? mockedDate : Date()
    }
    
func isValidDateTime() -> Bool {
        let currentDate = Date()
        return self <= currentDate // Ensures the date is not in the future
    }
}

private extension Date {
    
    private func fetchDateWithMockedHourMinute() -> Date {
        let currentDate = Date()
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: currentDate)
        components.hour = 6
        components.minute = 30
        let returnDate = calendar.date(from: components) ?? currentDate
        return returnDate
    }
}
