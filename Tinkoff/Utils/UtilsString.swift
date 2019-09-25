//
//  UtilsString.swift
//  Tinkoff
//
//  Created by Mr.Ocumare on 25/09/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import Foundation


func cleanHTMLTags(_ str : String) -> String {
    var string = str.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
    string = string.replacingOccurrences(of: "&[^;]+;", with: "", options: String.CompareOptions.regularExpression, range: nil)
    return string
}
