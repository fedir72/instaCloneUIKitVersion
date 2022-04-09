//
//  UserFollowTableViewCell.swift
//  instaClone
//
//  Created by Fedii Ihor on 05.04.2022.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollow(model: UserRelationShip)
}

enum FollowState {
    case following, not_following
}

struct UserRelationShip {
    let username: String
    let name: String
    var type: FollowState
}

class UserFollowTableViewCell: UITableViewCell {
    
   private var model: UserRelationShip?
   static let id = "UserFollowTableViewCell"
   public weak var delegate: UserFollowTableViewCellDelegate?
    
    private let profileImageView: UIImageView = {
        let v = UIImageView()
        v.layer.masksToBounds = true
        v.contentMode = .scaleAspectFill
        v.backgroundColor = .secondarySystemBackground
        return v
    }()
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Joe"
        lbl.font = .systemFont(ofSize: 17, weight: .semibold)
        return lbl
    }()
    
    private let userNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.font = .systemFont(ofSize: 15, weight: .regular)
        lbl.textColor = .secondaryLabel
        lbl.text = "@joe"
        return lbl
    }()
    
    private let followButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .link
        return btn
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(followButton)
        selectionStyle = .none
        followButton.addTarget(self, action: #selector(didtapFollowButton), for: .touchUpInside)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = .init(x: 3,
                                       y: 3,
                                       width: contentView.height - 6,
                                       height: contentView.height -  6)
        profileImageView.layer.cornerRadius = contentView.height/2
        
        let labelheight = contentView.height/2
        let buttonWidth = contentView.width > 550 ? 220 : contentView.width/3
        
        followButton.frame = .init(x: contentView.width-5-buttonWidth,
                                   y: 12.5,
                                   width: buttonWidth,
                                   height: 50)
        nameLabel.frame = .init(x: profileImageView.right+5,
                                y: 0,
                                width: contentView.width-8-profileImageView.width,
                                height: labelheight)
        userNameLabel.frame = .init(x: profileImageView.right+5,
                                    y: nameLabel.bottom,
                                width: contentView.width-8-profileImageView.width-buttonWidth,
                                height: labelheight)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        /*все свойства что переопределяются для более плавной
        работы таблицы переопределяем на нил или 0*/
        
        nameLabel.text = nil
        userNameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
        profileImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserRelationShip) {
        self.model = model
        nameLabel.text = model.name
        userNameLabel.text = model.username
        switch model.type {
        case .following:
            //show unfollow button
            followButton.setTitle("unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 2
            followButton.layer.borderColor = UIColor.lightGray.cgColor
        case .not_following:
            //show follow button
            followButton.setTitle("follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
            followButton.layer.borderColor = UIColor.label.cgColor
        }
    }
    
    @objc private func didtapFollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfollow(model: model)
    }
}
