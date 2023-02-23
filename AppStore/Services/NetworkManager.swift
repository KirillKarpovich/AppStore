//
//  NetworkManager.swift
//  AppStore
//
//  Created by Kirill Karpovich on 20.02.23.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func search(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> Void) {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
       
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchTopFree(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/25/apps.json"
        fetchGroupApp(urlString: urlString, completion: completion)
    }
    
    func fetchTopPaid(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/25/apps.json"
        fetchGroupApp(urlString: urlString, completion: completion)
    }
    
    func fetchGroupApp(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchSocialApps(completion: @escaping ([SocialApps]?, Error?) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
                
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
            }.resume()
    }
}
