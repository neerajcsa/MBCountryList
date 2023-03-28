//
//  Country.swift
//  MBCountryList
//
//  Created by Neeraj Pandey on 10/03/23.
//

import Foundation

struct Country : Decodable {
    let countryID : Int
    let countryName : String
    let countryCode : String
    let phoneCode : String?
    
    enum CodingKeys : String, CodingKey {
        case countryID = "ID"
        case countryName = "Name"
        case countryCode = "Code"
        case phoneCode = "PhoneCode"
    }
}
