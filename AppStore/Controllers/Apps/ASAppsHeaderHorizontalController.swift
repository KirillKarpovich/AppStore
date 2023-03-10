//
//  ASAppsHeaderHorizontalController.swift
//  AppStore
//
//  Created by Kirill Karpovich on 21.02.23.
//

import UIKit

class ASAppsHeaderHorizontalController: HorizontalSnappingVC, UICollectionViewDelegateFlowLayout {
        
    var socialApps = [SocialApps]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(ASAppsHeaderCell.self, forCellWithReuseIdentifier: ASAppsHeaderCell.identifier)
        
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialApps.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ASAppsHeaderCell.identifier, for: indexPath) as? ASAppsHeaderCell else {
            return UICollectionViewCell()
        }
        let app = socialApps[indexPath.row]
        cell.titleLabel.text = app.tagline
        cell.companyLabel.text = app.name
        cell.imageView.sd_setImage(with: URL(string: app.imageUrl))
        return cell
    }
    
}
