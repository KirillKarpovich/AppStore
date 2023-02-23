//
//  ASBaseListVC.swift
//  AppStore
//
//  Created by Kirill Karpovich on 21.02.23.
//

import UIKit

class ASBaseCollectionVC: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
