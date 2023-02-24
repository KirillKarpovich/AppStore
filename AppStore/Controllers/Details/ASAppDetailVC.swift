//
//  ASAppDetailVC.swift
//  AppStore
//
//  Created by Kirill Karpovich on 23.02.23.
//

import UIKit

class ASAppDetailVC: ASBaseCollectionVC, UICollectionViewDelegateFlowLayout {
    
    var appId: String! {
        didSet {
            let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
            NetworkManager.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, err) in
                let app = result?.results.first
                self.app = app
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    var app: Result?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(ASAppDetailCell.self, forCellWithReuseIdentifier: ASAppDetailCell.identifier)
        collectionView.register(ASPreviewCell.self, forCellWithReuseIdentifier: ASPreviewCell.identifier)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ASAppDetailCell.identifier, for: indexPath) as? ASAppDetailCell
            else { return UICollectionViewCell() }
            cell.app = app
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ASPreviewCell.identifier, for: indexPath) as? ASPreviewCell
            else { return UICollectionViewCell() }
            cell.horizontalController.app = self.app
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        if indexPath.item == 0 {
            let dummyCell = ASAppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.app = app
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            
            return .init(width: view.frame.width, height: estimatedSize.height)
        } else {
            return .init(width: view.frame.width, height: 500)
        }
    }
    
}
