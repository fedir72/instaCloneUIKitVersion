//
//  ProfileTabsCollectionReusableView.swift
//  instaClone
//
//  Created by Fedii Ihor on 02.04.2022.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    
        static let id = "ProfileTabsCollectionReusableView"
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
