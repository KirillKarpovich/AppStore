//
//  SearchViewController.swift
//  AppStore
//
//  Created by Kirill Karpovich on 20.02.23.
//

import UIKit

class ASSearchVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(SearchResutlCell.self, forCellWithReuseIdentifier: SearchResutlCell.identifier)
        collectionView.backgroundColor = .brown
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResutlCell.identifier, for: indexPath) as? SearchResutlCell else { return UICollectionViewCell()}
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
}
