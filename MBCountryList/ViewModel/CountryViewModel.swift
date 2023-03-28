//
//  CountryViewModel.swift
//  MBCountryList
//
//  Created by Neeraj Pandey on 10/03/23.
//

import Foundation

class CountryViewModel {
    
    var arrCountryList : [Country] = [] {
        didSet {
            completionSuccess?()
        }
    }
    
    var completionSuccess : (() -> Void)?
    var completionError : ((MBError) -> Void)?
    
    init() { }
    
    func fetchCountryData() {
        NetworkManager.shared.getAllCountryData { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let countryData):
                self.arrCountryList = countryData
            case .failure(let error):
                self.completionError?(error)
            }
        }
    }
    
}
