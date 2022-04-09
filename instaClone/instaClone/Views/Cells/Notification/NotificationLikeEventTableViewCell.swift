//
//  NotificationLikeEventTableViewCell.swift
//  instaClone
//
//  Created by Fedii Ihor on 06.04.2022.
//

import UIKit

protocol NotificationLikeEventTablevieCellDelegate: AnyObject {
    func didTabRalatedPostButton(model: String)
}
class NotificationLikeEventTableViewCell: UITableViewCell {

   static let id = "NotificationLikeEventTableViewCell"
    
  weak var delegate: NotificationFollowEventTablevieCellDelegate?
    
    private  let profileImageView: UIImageView = {
        let img = UIImageView()
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .label
        //lbl.font = .systemFont(ofSize: 17, weight: .semibold)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let postButton: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        
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
    }
    
    public func configure(with model: String) {
        
    }
}
