//
//  IGFeedPostGeneralTableViewCell.swift
//  instaClone
//
//  Created by Fedii Ihor on 01.04.2022.
//

import UIKit

//Comments
class IGFeedPostGeneralTableViewCell: UITableViewCell {

    static let id = "IGFeedPostGeneralTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemOrange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        
    }

}
