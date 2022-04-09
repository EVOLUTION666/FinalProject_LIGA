//
//  Date + Ext.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 09.04.2022.
//

import Foundation

extension Date {
    static var currentMonth: String {
        return buildDateFormatter(dateFormat: "MMMM").string(from: Date())
    }
    
    static var currentYear: String {
        return buildDateFormatter(dateFormat: "YYYY").string(from: Date())
    }
    
    private static func buildDateFormatter(dateFormat: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en-EN")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter
    }
}
