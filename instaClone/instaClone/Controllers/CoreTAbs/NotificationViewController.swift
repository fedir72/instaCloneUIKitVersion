//
//  NotificationViewController.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//

import UIKit
import SnapKit

enum UsernotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
    
}

struct UserNotification {
    let type: UsernotificationType
    let text: String
    let user: User
}

final class NotificationViewController: UIViewController{
    
    private var tableview: UITableView = {
        let tbl = UITableView()
        tbl.isHidden = false
        tbl.register(NotificationFollowEventTableViewCell.self,
                     forCellReuseIdentifier: NotificationFollowEventTableViewCell.id)
        tbl.register(NotificationLikeEventTableViewCell.self,
                     forCellReuseIdentifier: NotificationLikeEventTableViewCell.id)
        return tbl
    }()
    
    private var spinner: UIActivityIndicatorView = {
        let i = UIActivityIndicatorView(style: .large)
        //i.startAnimating()
        i.hidesWhenStopped =  true
        i.tintColor = .systemRed
        return i
    }()
    
    private lazy var notificationView = NotificationView()
    private var models = [UserNotification]()

    override func viewDidLoad() {
        super.viewDidLoad()
         fetchNotification()
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
        tableview.delegate = self
        tableview.dataSource =  self
        view.addSubview(notificationView)
        view.addSubview(tableview)
        view.addSubview(spinner)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = .init(x: 0, y: 100, width: view.width, height: view.height - 200  )
        spinner.frame = .init(x: 0, y: 0, width: 80, height: 80)
        spinner.center = view.center
    }
    
    private func addNoNotificationView() {
        tableview.isHidden = true
        notificationView.frame =  .init(x: 0, y: 0, width: view.frame.width/2, height: view.frame.width/4)
        notificationView.center = view.center
    }
    
    private func fetchNotification() {
        for x in 1...50 {
            let post = UserPost(identifire: "",
                                postType: .photo,
                                thumbnailImage: URL(string: "https://www.google.com/")!,
                                postUrl: URL(string: "https://www.google.com/")!,
                                caption: nil,
                                likeCount: [],
                                comments: [],
                                createdDate: Date(),
                                    taggedusers: [])
            let model = UserNotification(type: x%2 == 0 ? .like(post: post ) : .follow(state: .not_following),
                                         text: "Hello world",
                                         user: .init(userNAme: "Joe", bio: "Bio",
                                                     name: (first: "Joe", second: "Smith"),
                                                     birdthdate: Date(),
                                                     gender: .male,
                                                     counts: UserCount(folowers: 10,
                                                                       following: 10,
                                                                       posts: 111),
                                                     joinedDate: Date(),
                                                     profilePhoto: URL(string: "https://www.google.com/")!))
            models.append(model)
        }
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(_):
            //like cell
           let cell = tableview.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.id,
                                                     for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            cell.backgroundColor = .yellow
            return cell
        case .follow:
            //follow cell
            let cell = tableview.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.id,
                                                     for: indexPath)
            as! NotificationFollowEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row % 2 == 0 {
//            return 80
//        }else{
//            return 50
//        }
        return 54
    }
}

//MARK: - NotificationLikeEventTablevieCellDelegate
extension NotificationViewController: NotificationLikeEventTablevieCellDelegate {
    func didTabRalatedPostButton(model: UserNotification) {
        print("tapped post")
        //open the post
    }
}

extension NotificationViewController: NotificationFollowEventTablevieCellDelegate {
   
    func didTabFollowUnfollowButton(model: UserNotification) {
        print("tapped button")
        //perform database update
    }
}
