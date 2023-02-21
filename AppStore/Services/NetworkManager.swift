//
//  NetworkManager.swift
//  AppStore
//
//  Created by Kirill Karpovich on 20.02.23.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> Void) {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                print("Failed to fetch apps:", err)
                completion([], nil)
                return
            }
            
            guard let data = data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
                completion(searchResult.results, nil)
                
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
                completion([], jsonErr)
            }
            
             }.resume()
    }
    
}
