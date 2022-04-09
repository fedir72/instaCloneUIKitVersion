//
//  NotificationView.swift
//  instaClone
//
//  Created by Fedii Ihor on 06.04.2022.
//

import UIKit

class NotificationView: UIView {
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.text = "No notification yet"
        lbl.textColor = .secondaryLabel
        lbl.textAlignment = .center
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.tintColor = .secondaryLabel
        img.contentMode = .scaleAspectFit
        img.image = .init(systemName: "bell")
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = .init(x: (width-80)/2, y: 0, width: 80, height: 80).integral
        label.frame = .init(x: 0, y: imageView.bottom, width: width, height: height-80).integral
    }

}
