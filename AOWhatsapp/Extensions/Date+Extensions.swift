//
//  Date+Extensions.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 11/08/22.
//

import Foundation

extension Date {
    static func from(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int) -> Date?
    {
        let gregorianCalendar = Calendar(identifier: .gregorian)
        let dateComponents = DateComponents(calendar: gregorianCalendar, year: year, month: month, day: day, hour: hour, minute: minute)
        return gregorianCalendar.date(from: dateComponents)
    }
    
    public func getMessageHour(date: Date, dateFormatter: DateFormatter) -> String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    public func getMessageDate(date: Date, dateFormatter: DateFormatter) -> String {
        let diffComponents = Calendar.current.dateComponents([.day], from: date, to: Date())
        if let days = diffComponents.day {
            if days == 0 {
                dateFormatter.dateFormat = "HH:mm"
                return dateFormatter.string(from: date)
            }
            if days == 1 {
                return "Ieri"
            }
            if days > 7 {
                dateFormatter.dateFormat = "dd/MM/YYYY"
                return dateFormatter.string(from: date)
            }
            if days > 1 {
                dateFormatter.dateFormat = "EEEE"
                return dateFormatter.string(from: date)
            }
        }
        return ""
    }
}
