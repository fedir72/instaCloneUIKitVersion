//
//  PhotoCollectionViewCell.swift
//  instaClone
//
//  Created by Fedii Ihor on 02.04.2022.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let id = "PhotoCollectionViewCell"
    let photoImageVie: UIImageView = {
        let v = UIImageView()
        v.clipsToBounds =  true
        v.contentMode = .scaleAspectFill
        return v
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageVie.frame = contentView.bounds
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageVie.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(photoImageVie)
        contentView.clipsToBounds = true
        accessibilityLabel = "user post image"
        accessibilityHint = "Double-tap to open post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserPost ) {
        let url = model.thumbnailImage
        self.photoImageVie.sd_setImage(with: url)
    }
    
    public func configure(debug imageName: String) {
        photoImageVie.image = UIImage(named: imageName)
    }
    
}
