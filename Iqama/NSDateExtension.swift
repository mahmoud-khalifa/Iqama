//
//  NSDateExtension.swift
//  Iqama
//
//  Created by Mahmoud Adam on 11/1/16.
//  Copyright © 2016 lognlabs. All rights reserved.
//

import Foundation

extension NSDate {
    func getFormattedTime() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = Constants.timeZone
        
        let formattedTime = dateFormatter.stringFromDate(self)
        return formattedTime
    }
}
