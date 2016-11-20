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
    case FridayPray
}

class Pray: NSObject {
    // Constants
    static let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    
    // instance variables
    private var prayType: PrayType
    private var formattedTime: String
    
    
    init(prayType: PrayType, formattedTime: String) {
        self.prayType = prayType
        self.formattedTime = formattedTime
        super.init()
    }

    
    func getFormatedPrayTime() -> String {
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
        case .FridayPray:
            return "AlGomaa"
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
        case .FridayPray:
            return "الجمعة"
        }
    }
    
    func getPrayDateTime(date: NSDate) -> NSDate {
        let startOfDay = Pray.cal.startOfDayForDate(date)
        let timeSinceMidnight = getTimeSinceMidnight(prayType, formatedTime: formattedTime)
        let prayDateTime = startOfDay.dateByAddingTimeInterval(timeSinceMidnight)
        return prayDateTime
    }
    
    private func getTimeSinceMidnight(prayType: PrayType, formatedTime: String) -> NSTimeInterval {
        let timeComponents = formatedTime.componentsSeparatedByString(":")
        guard timeComponents.count == 2 else {
            return 0
        }
        
        let hours = Double(timeComponents[0])! + (prayType == .Fajir ? 0 : 12)
        let minutes = Double(timeComponents[1])!
        
        let timeSinceMidnight = hours * 3600.0 + minutes * 60.0
        return timeSinceMidnight
        
    }
    
}
