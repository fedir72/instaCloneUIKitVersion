//
//  IGFeedPostTableViewCell.swift
//  instaClone
//
//  Created by Fedii Ihor on 01.04.2022.
//

import UIKit

class IGFeedPostTableViewCell: UITableViewCell {
    
    static let id = "IGFeedPostTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        
    }
    
}
