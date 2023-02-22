//
//  AppsViewController.swift
//  AppStore
//
//  Created by Kirill Karpovich on 20.02.23.
//

import UIKit

class ASAppsPageVC: ASBaseCollectionVC, UICollectionViewDelegateFlowLayout {
    
    let headerId = "headerId"
    var groups = [AppGroup]()
    var socialApps = [SocialApps]()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large )
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        collectionView.register(ASAppsGroupCell.self, forCellWithReuseIdentifier: ASAppsGroupCell.identifier)
        collectionView.register(ASAppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: headerId)
        
        fetchData()
    }
    
    private func fetchData() {
        
        let dispatchGroup = DispatchGroup()
        
        var group1: AppGroup?
        var group2: AppGroup?
        
        
        dispatchGroup.enter()
        NetworkManager.shared.fetchTopFree { (appGroup, error) in
            dispatchGroup.leave()
            if let error = error {
                print("Failed to fetch games:", error)
                return
            }
            group1 = appGroup
        }
        dispatchGroup.enter()
        NetworkManager.shared.fetchTopPaid { appGroup, error in
            dispatchGroup.leave()
            if let error = error {
                print("Failed to fetch games:", error)
                return
            }
            group2 = appGroup
        }
        dispatchGroup.enter()
        NetworkManager.shared.fetchSocialApps { apps, error in
            dispatchGroup.leave()
            self.socialApps = apps ?? []
        }
        
        dispatchGroup.notify(queue: .main) {
            if let group = group1 {
                self.groups.append(group)
            }
            if let group = group2 {
                self.groups.append(group)
            }
            self.activityIndicatorView.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? ASAppsPageHeader else {
            return UICollectionReusableView()
        }
        header.appHeaderHorizontalController.socialApps = self.socialApps
        header.appHeaderHorizontalController.collectionView.reloadData()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ASAppsGroupCell.identifier, for: indexPath) as? ASAppsGroupCell else { return UICollectionViewCell() }
        
        let appGroup = groups[indexPath.item]
        
        cell.titleLabel.text = appGroup.feed.title
        cell.horizontalController.appGroup = appGroup
        cell.horizontalController.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
}
