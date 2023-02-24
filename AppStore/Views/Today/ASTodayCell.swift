//
//  ASTodayCell.swift
//  AppStore
//
//  Created by Kirill Karpovich on 24.02.23.
//

import UIKit

class ASTodayCell: UICollectionViewCell {
    static let identifier = String(describing: ASTodayCell.self)
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.centerInSuperview(size: .init(width: 250, height: 250))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}

