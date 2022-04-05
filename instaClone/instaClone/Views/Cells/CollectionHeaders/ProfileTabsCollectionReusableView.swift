//
//  ProfileTabsCollectionReusableView.swift
//  instaClone
//
//  Created by Fedii Ihor on 02.04.2022.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTApGridButtonTab()
    func didTApTAggedButtonTAb()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    
    struct Constant {
        static let padding: CGFloat = 2
    }
    
    static let id = "ProfileTabsCollectionReusableView"
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    //MARK: - properties
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addSubview(taggedButton)
        addSubview(gridButton)
        
        taggedButton.addTarget(self,
                               action: #selector(didTApTaggedButtonTab),
                               for: .touchUpInside)
        gridButton.addTarget(self,
                             action: #selector(didTapGridButton),
                             for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height - Constant.padding*2
        let gridButtonX = ((width/2) - size)/Constant.padding
        gridButton.frame = .init(x: gridButtonX, y: Constant.padding, width: size, height: size)
        taggedButton.frame = .init(x:gridButtonX+(width/2) , y: Constant.padding, width: size, height: size)
    }
}

extension ProfileTabsCollectionReusableView {
    
   @objc private func didTapGridButton() {
       gridButton.tintColor = .systemBlue
       taggedButton.tintColor = .lightGray
       delegate?.didTApGridButtonTab()
    }
   @objc private func didTApTaggedButtonTab() {
       gridButton.tintColor = .lightGray
       taggedButton.tintColor = .systemBlue
       delegate?.didTApTAggedButtonTAb()
    }
}
