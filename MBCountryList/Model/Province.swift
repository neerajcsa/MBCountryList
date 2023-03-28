//
//  Province.swift
//  MBCountryList
//
//  Created by Neeraj Pandey on 10/03/23.
//

import Foundation

struct Province : Decodable {
    let provinceID : Int
    let provinceName : String
    let countryCode : String
    let provinceCode : String
    
    enum CodingKeys : String, CodingKey {
        case provinceID = "ID"
        case provinceName = "Name"
        case countryCode = "CountryCode"
        case provinceCode = "Code"
    }
}

