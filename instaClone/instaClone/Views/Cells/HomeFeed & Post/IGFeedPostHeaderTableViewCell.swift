//
//  IGFeedPostHeaderTableViewCell.swift
//  instaClone
//
//  Created by Fedii Ihor on 01.04.2022.
//

import UIKit

protocol IGFeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton()
}
class IGFeedPostHeaderTableViewCell: UITableViewCell {
     
    weak var delegate: IGFeedPostHeaderTableViewCellDelegate?
    static let id = "IGFeedPostHeaderTableViewCell"
    
    private let profileImageView: UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFill
        imgv.clipsToBounds = true
        imgv.layer.masksToBounds = true
        return imgv
    }()
    
    private var moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    
    private var usernamelabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //contentView.backgroundColor = .systemBlue
        contentView.addSubview(profileImageView)
        contentView.addSubview(usernamelabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernamelabel.text = nil
        profileImageView.image = nil
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.height - 4
        profileImageView.frame = CGRect(x: 2, y: 2, width: size, height: size)
        profileImageView.layer.cornerRadius = size/2
        moreButton.frame = CGRect(x: contentView.width-size,
                                  y: 2,
                                  width: size,
                                  height: size )
        usernamelabel.frame = CGRect(x: profileImageView.right+10,
                                  y: 2,
                                  width: contentView.width-(size*2)-15,
                                  height: contentView.height-4)
    }
    
    public func configure(with model: User) {
        usernamelabel.text = model.userNAme
        profileImageView.image = UIImage(systemName: "person.circle")
       // profileImageView.sd_setImage(with: model.profilePhoto)
    }
    
}

extension IGFeedPostHeaderTableViewCell  {
    @objc private func didTapButton() {
        delegate?.didTapMoreButton()
    }
}
