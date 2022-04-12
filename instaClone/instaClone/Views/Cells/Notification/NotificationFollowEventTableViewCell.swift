//
//  NotificationFollowEventTableViewCell.swift
//  instaClone
//
//  Created by Fedii Ihor on 06.04.2022.
//

import UIKit

protocol NotificationFollowEventTablevieCellDelegate: AnyObject {
    func didTabFollowUnfollowButton(model: UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {
    
    static let id = "NotificationFollowEventTableViewCell"
    weak var delegate: NotificationFollowEventTablevieCellDelegate?
    private var model: UserNotification?
    
    private  let profileImageView: UIImageView = {
        let img = UIImageView()
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFill
        img.backgroundColor = .lightGray
        return img
    }()
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        //lbl.font = .systemFont(ofSize: 17, weight: .semibold)
        lbl.numberOfLines = 0
        lbl.text = "@KanyeWest started follow you"
        return lbl
    }()
    
    private let followButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 6
        btn.layer.masksToBounds = true
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTApFollowButton), for: .touchUpInside)
        conffigureForFollow()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image =  nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //photo , text , post button
        profileImageView.frame = .init(x: 3,
                                    y: 3,
                                    width: contentView.height-6,
                                    height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        let size: CGFloat = 100
        followButton.frame = .init(x: contentView.width-5-size,
                                   y: (contentView.height-44)/2,
                                   width: 100,
                                   height: 44)
        //followButton.backgroundColor = .orange
        label.frame = .init(x: profileImageView.right+5,
                            y: 2,
                            width:contentView.width-size-profileImageView.width-16 ,
                            height:contentView.height )
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
            
        case .like(_):
           break
        case .follow(let state):
            switch state {
                 //configure button
            case .following:
                 //show unfollow button
               conffigureForFollow()
            case .not_following:
                 //show follow button
               conffigureForUnFollow()
                }
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
   @objc private func didTApFollowButton() {
        guard let model = model else { return }
        delegate?.didTabFollowUnfollowButton(model: model)
    }
    
    private func conffigureForFollow() {
        followButton.setTitle("Unfollow", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 2
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    private func conffigureForUnFollow() {
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitleColor(.white, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = .link
    }
    
}
