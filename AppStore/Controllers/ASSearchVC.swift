//
//  SearchViewController.swift
//  AppStore
//
//  Created by Kirill Karpovich on 20.02.23.
//

import UIKit
import SDWebImage

class ASSearchVC: ASBaseCollectionVC, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    private var appResults = [Result]()
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let searchLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above...🦉"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SearchResutlCell.self, forCellWithReuseIdentifier: SearchResutlCell.identifier)
        collectionView.addSubview(searchLabel)
        searchLabel.fillSuperview(padding: .init(top: 100, left: 30, bottom: 0, right: 0))
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NetworkManager.shared.search(searchTerm: searchText) { result, error in
            self.appResults = result?.results ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func fetchITunesApps() {
        NetworkManager.shared.search(searchTerm: "Instagram") { (results, err) in
            
            if let err = err {
                print("Failed to fetch apps:", err)
                return
            }
            
            self.appResults = results?.results ?? []
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResutlCell.identifier, for: indexPath) as? SearchResutlCell else { return UICollectionViewCell()}
        
        cell.appResult = appResults[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchLabel.isHidden = !appResults.isEmpty
        return appResults.count
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = String(appResults[indexPath.item].trackId)
        let detailVC = ASAppDetailVC(appId: appId)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
