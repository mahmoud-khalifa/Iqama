//
//  Pray.swift
//  Iqama
//
//  Created by Mahmoud Adam on 11/6/16.
//  Copyright © 2016 lognlabs. All rights reserved.
//

import Foundation

public enum PrayType {
    case Fajir
    case Dhuhr
    case Asr
    case Maghrib
    case Isha
}

class Pray: NSObject {
    // Constants
    static let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    static let dateFormatter = NSDateFormatter()
    
    // instance variables
    private var prayType: PrayType
    private var prayDateTime: NSDate
    
    
    override class func initialize() {
        cal.timeZone = Constants.timeZone
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = Constants.timeZone
    }
    
    init(prayType: PrayType, date: NSDate, timeSinceMidnight: Double) {
        self.prayType = prayType
        let startOfDay = Pray.cal.startOfDayForDate(date)
        self.prayDateTime = startOfDay.dateByAddingTimeInterval(timeSinceMidnight)
        super.init()
    }

    
    func getFormatedPrayTime() -> String {
        
        let formattedTime = Pray.dateFormatter.stringFromDate(prayDateTime)
        return formattedTime
    }
    
    func getEnglishName() -> String {
        switch prayType {
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
        switch prayType {
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
