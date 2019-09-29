//
//  UtilsDate.swift
//  Tinkoff
//
//  Created by Mr.Ocumare on 25/09/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import Foundation


public class DataUtils {
    class func dateStringFormat(_ str: String) -> String {
        let dateFor: DateFormatter = DateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        let yourDate: NSDate? = dateFor.date(from: str) as NSDate?
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        let displayString = dateFormatter.string(from: yourDate! as Date)
        return displayString
    }
}


