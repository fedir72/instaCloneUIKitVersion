//
//  ProfileCollectionReusableView.swift
//  instaClone
//
//  Created by Fedii Ihor on 02.04.2022.
//

import UIKit

class ProfileCollectionReusableView: UICollectionReusableView {
        static let id = "ProfileCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
