//
//  IGFeedPostTableViewCell.swift
//  instaClone
//
//  Created by Fedii Ihor on 01.04.2022.
//

import UIKit
import SDWebImage
import AVFoundation

class IGFeedPostTableViewCell: UITableViewCell {
    
    
    
    static let id = "IGFeedPostTableViewCell"
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer = AVPlayerLayer()
    
    private let postImageView: UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFill
        imgv.backgroundColor = nil
        imgv.clipsToBounds = true
        return imgv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postImageView.frame = contentView.bounds
        playerLayer.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    
    public func configure(with post: UserPost) {
        
        postImageView.image = UIImage(named: "test")
        return
        
        switch post.postType {
            
        case .photo://show image
            postImageView.sd_setImage(with: post.postUrl,completed: nil)
        case .video://load and play video
            player = AVPlayer(url: post.postUrl)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
    }
    
}
