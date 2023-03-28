//
//  ProvinceViewModel.swift
//  MBCountryList
//
//  Created by Neeraj Pandey on 10/03/23.
//

import Foundation

class ProvinceViewModel {
    let country : Country
    
    var arrProvinceList : [Province] = [] {
        didSet {
            completionSuccess?()
        }
    }
    
    var completionSuccess : (() -> Void)?
    var completionError : ((MBError) -> Void)?
    
    init(country : Country) {
        self.country = country
    }
    
    func fetchProvinceData() {
        NetworkManager.shared.getAllProvinceData(for: "\(self.country.countryID)") {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let provinceData):
                self.arrProvinceList = provinceData
            case .failure(let error):
                self.completionError?(error)
            }
        }
    }
    
}
