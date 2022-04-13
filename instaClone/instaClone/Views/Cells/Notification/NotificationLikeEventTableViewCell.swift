//
//  NotificationLikeEventTableViewCell.swift
//  instaClone
//
//  Created by Fedii Ihor on 06.04.2022.
//

import UIKit
import SDWebImage

protocol NotificationLikeEventTablevieCellDelegate: AnyObject {
    func didTabRalatedPostButton(model: UserNotification)
}
class NotificationLikeEventTableViewCell: UITableViewCell {

    static let id = "NotificationLikeEventTableViewCell"
    private var model: UserNotification?
    weak var delegate: NotificationLikeEventTablevieCellDelegate?
    
    private  let profileImageView: UIImageView = {
        let img = UIImageView()
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFill
        img.backgroundColor = .systemBlue
        //img.image = UIImage(systemName: "person")
        return img
    }()
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        //lbl.font = .systemFont(ofSize: 17, weight: .semibold)
        lbl.numberOfLines = 0
        lbl.text = "@Joe like your photo"
        return lbl
    }()
    
    private let postButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "test"), for: .normal)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setTitle(nil, for: .normal)
        postButton.backgroundColor = nil
        postButton.layer.borderWidth = 0
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
        let size = contentView.height - 4
        postButton.frame = .init(x: contentView.width-5-size, y: 2, width:size , height: size)
        label.frame = .init(x: profileImageView.right+5,
                            y: 2,
                            width:contentView.width-size-profileImageView.width-16 ,
                            height:contentView.height )
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
            
        case .like(let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString .contains("google.com") else { return }
            postButton.sd_setImage(with: thumbnail, for: .normal, completed: nil)
        case .follow:
             break
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
    @objc func didTapPostButton() {
        guard let model = model else { return }
        delegate?.didTabRalatedPostButton(model: model)
    }
}
