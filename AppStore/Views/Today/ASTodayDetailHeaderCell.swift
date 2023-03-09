//
//  ASTodayDetailHeaderCell.swift
//  AppStore
//
//  Created by Kirill Karpovich on 25.02.23.
//

import UIKit

class ASTodayDetailHeaderCell: UITableViewCell {
    
    let todayCell = ASTodayCell()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(todayCell)
        todayCell.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

