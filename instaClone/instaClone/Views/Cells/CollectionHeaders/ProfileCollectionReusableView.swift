//
//  ProfileCollectionReusableView.swift
//  instaClone
//
//  Created by Fedii Ihor on 02.04.2022.
//

import UIKit

protocol ProfileCollectionReusableViewDelegate: AnyObject {
    
    func profileHeaderDidTapPostButton(_ header: ProfileCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileCollectionReusableView)
}


final class ProfileCollectionReusableView: UICollectionReusableView {
    
    weak var delegate: ProfileCollectionReusableViewDelegate?
    static let id = "ProfileCollectionReusableView"
    
    private let profilePhotoImageView: UIImageView = {
        let imv = UIImageView()
        imv.backgroundColor = .red
        imv.layer.masksToBounds = true
        return imv
    }()
    
    private let postButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .label
        btn.backgroundColor = .secondarySystemBackground
        btn.setTitle("Posts", for: .normal)
        return btn
    }()
    
    private let followingButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .label
        btn.backgroundColor = .secondarySystemBackground
        btn.setTitle("Followin", for: .normal)
        return btn
    }()
    
    private let followerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .label
        btn.backgroundColor = .secondarySystemBackground
        btn.setTitle("Followers", for: .normal)
        return btn
    }()
    
    private let editProfileButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .label
        btn.backgroundColor = .secondarySystemBackground
        btn.setTitle("Edit your profile", for: .normal)
        return btn
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Joe Smith"
        lbl.textColor = .label
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let bioLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "This is the first account"
        lbl.textColor = .label
        lbl.numberOfLines = 0 //line wrap
        return lbl
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addsubviews()
        addButtonActions()
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //backgroundColor = .systemBlue
        setupLayouts()
    }
    
    private func addsubviews() {
        addSubview(profilePhotoImageView)
        addSubview(postButton)
        addSubview(followerButton)
        addSubview(followingButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    private func addButtonActions() {
        followerButton.addTarget(self,
                                 action: #selector(didtapFollowerButton),
                                 for: .touchUpInside)
        followingButton.addTarget(self,
                                 action: #selector(didtapFollowingButton),
                                 for: .touchUpInside)
        postButton.addTarget(self,
                                 action: #selector(didtapPostButton),
                                 for: .touchUpInside)
        editProfileButton.addTarget(self,
                                 action: #selector(didtapEditprofileButton),
                                 for: .touchUpInside)
    }
    
    private func setupLayouts() {
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: profilePhotoSize,
            height: profilePhotoSize
        ).integral
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2
        
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width-10-profilePhotoSize)/3
        postButton.frame = CGRect(
            x: profilePhotoImageView.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        followerButton.frame = CGRect(
            x: postButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        followingButton.frame = CGRect(
            x: followerButton.right,
            y: 5,
            width: countButtonWidth,
            height: buttonHeight
        ).integral
        
        editProfileButton.frame = CGRect(
            x: profilePhotoImageView.right,
            y: 5 + buttonHeight,
            width: countButtonWidth*3,
            height: buttonHeight
        ).integral
        
        nameLabel.frame = CGRect(
            x: 5,
            y: 5 + profilePhotoImageView.bottom,
            width: width-10,
            height: 50).integral
        let biolabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(
            x: 5,
            y: 5 + nameLabel.bottom,
            width: width-10,
            height: biolabelSize.height
        ).integral
    }
    
    //MARK: - actions
    
    @objc func didtapFollowerButton() {
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    
    @objc func didtapFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    
    @objc func didtapPostButton() {
        delegate?.profileHeaderDidTapPostButton(self)
    }
    
    @objc func didtapEditprofileButton() {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
    
}
