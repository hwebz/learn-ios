//
//  User.swift
//  Appetizers
//
//  Created by Personal on 29/09/2023.
//

import Foundation

struct User: Codable  {
    var firstName       = ""
    var lastName        = ""
    var email           = ""
    var birthDate       = Date()
    var extraNapkins    = true
    var frequentRefill  = false
}
