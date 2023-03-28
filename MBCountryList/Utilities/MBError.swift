//
//  MBError.swift
//  MBCountryList
//
//  Created by Neeraj Pandey on 10/03/23.
//

import Foundation

enum MBError : String,Error {
    case unableToComplete = "Unable to complete your request. Please chekc your internet connection."
    case invalidResponse = "Invalid response from server. Please try again."
    case invalidData = "The data received from server was invalid. Please try again."    
}
