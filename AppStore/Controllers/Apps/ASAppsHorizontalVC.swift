//
//  ASAppsHorizontalVC.swift
//  AppStore
//
//  Created by Kirill Karpovich on 21.02.23.
//

import UIKit
import SDWebImage

class ASAppsHorizontalVC: HorizontalSnappingVC, UICollectionViewDelegateFlowLayout {
    
    var appGroup: AppGroup?
    
    var didSelectHandler: ((FeedResult) -> ())?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(ASAppRowCell.self, forCellWithReuseIdentifier: ASAppRowCell.identifier)
        
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ASAppRowCell.identifier, for: indexPath) as? ASAppRowCell else { return UICollectionViewCell() }
        let app = appGroup?.feed.results[indexPath.row]
        cell.nameLabel.text = app?.name
        cell.companyLabel.text = app?.artistName
        cell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))

        return cell
    }
    
    let topBottomPadding: CGFloat = 12
    let lineSpacing: CGFloat = 10
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 2 * topBottomPadding - 2 * lineSpacing) / 3
        return .init(width: view.frame.width - 48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = appGroup?.feed.results[indexPath.item] {
            didSelectHandler?(app)

        }
    }
    
}
