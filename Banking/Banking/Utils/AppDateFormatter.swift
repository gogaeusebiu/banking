//
//  DateUtils.swift
//  Banking
//
//  Created by Goga Eusebiu on 12.08.2021.
//

import Foundation

class AppDateFormatter {
    var formatter = DateFormatter()
    
    var dateFormatter : DateFormatter{
        get {
            // date shown as date in some tableviews
            formatter.dateFormat = "dd MM yyyy"
            return formatter
        }
    }
    
    class var sharedManager : AppDateFormatter {
        struct Static {
            static let instance : AppDateFormatter = AppDateFormatter()
        }
        return Static.instance
    }
    
    func stringFromDate(date: Date) -> String {
        return self.dateFormatter.string(from: date as Date)
    }
    func dateFromString(date: String) -> Date {
        return self.dateFormatter.date(from: date)!
    }
    
    func addYearsToDate(_ date: Date, _ years: Int) -> Date {
        var dateComponent = DateComponents()
        
        dateComponent.year = years
        
        return Calendar.current.date(byAdding: dateComponent, to: date)!
    }
    
    func isFutureDate(_ date: Date) -> Bool {
        let nowDate = Date()
        
        return nowDate < date
    }
}
