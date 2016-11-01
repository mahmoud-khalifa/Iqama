//
//  PrayType.swift
//  Iqama
//
//  Created by Mahmoud Adam on 11/1/16.
//  Copyright © 2016 lognlabs. All rights reserved.
//

import Foundation

public enum PrayType {
    case Fajir      (Double)
    case Dhuhr      (Double)
    case Asr        (Double)
    case Maghrib    (Double)
    case Isha       (Double)
    
    
    func getPrayDateTime(date: NSDate) -> NSDate {
        
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        cal.timeZone = Constants.timeZone
        let startOfDay = cal.startOfDayForDate(date)
        var prayTime = 0.0
        
        let mirror = Mirror(reflecting: self)
        if let associated = mirror.children.first {
            prayTime = associated.value as! Double
        }
        let prayDateTime = startOfDay.dateByAddingTimeInterval(prayTime)
        return prayDateTime
    }
    
    func getEnglishName() -> String {
        switch self {
        case .Fajir:
            return "Fajir"
        case .Dhuhr:
            return "Dhuhr"
        case .Asr:
            return "Asr"
        case .Maghrib:
            return "Maghrib"
        case .Isha:
            return "Isha"
        }
    }
    
    func getArabicName() -> String {
        switch self {
        case .Fajir:
            return "الفجر"
        case .Dhuhr:
            return "الظهر"
        case .Asr:
            return "العصر"
        case .Maghrib:
            return "المغرب"
        case .Isha:
            return "العشاء"
        }
    }
}
