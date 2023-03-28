//
//  NetworkManager.swift
//  MBCountryList
//
//  Created by Neeraj Pandey on 10/03/23.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    private init() { }
    
    private let baseUrl = "https://connect.mindbodyonline.com"
        
    func getAllCountryData(completed : @escaping (Result<[Country], MBError>) -> Void) {
        let endpoint = baseUrl + "/rest/worldregions/country"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidData))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let arrCountryData = try decoder.decode([Country].self, from: data)
                completed(.success(arrCountryData))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
    func getAllProvinceData(for countryId : String, completed : @escaping (Result<[Province], MBError>) -> Void) {
        let endpoint = baseUrl + "/rest/worldregions/country/\(countryId)/province"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidData))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let arrProvinceData = try decoder.decode([Province].self, from: data)
                completed(.success(arrProvinceData))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
    
}
