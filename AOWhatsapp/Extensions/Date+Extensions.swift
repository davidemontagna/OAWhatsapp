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
}
