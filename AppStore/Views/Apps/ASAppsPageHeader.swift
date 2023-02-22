//
//  ASAppsPageHeader.swift
//  AppStore
//
//  Created by Kirill Karpovich on 21.02.23.
//

import UIKit

class ASAppsPageHeader: UICollectionReusableView { 
    static let identifier = String(describing: ASAppsPageHeader.self)
    
    let appHeaderHorizontalController = ASAppsHeaderHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(appHeaderHorizontalController.view)
        appHeaderHorizontalController.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
