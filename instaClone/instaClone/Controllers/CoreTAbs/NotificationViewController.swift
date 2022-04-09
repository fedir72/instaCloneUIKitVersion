//
//  NotificationViewController.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//

import UIKit

class NotificationViewController: UIViewController {
    
    private var tableview: UITableView = {
        let tbl = UITableView()
        tbl.isHidden = false
        tbl.register(NotificationLikeEventTableViewCell.self,
                     forCellReuseIdentifier: NotificationLikeEventTableViewCell.id)
        tbl.register(NotificationFollowEventTableViewCell.self,
                     forCellReuseIdentifier: NotificationFollowEventTableViewCell.id)
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

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
        tableview.delegate = self
        tableview.dataSource =  self
        //view.addSubview(notificationView)
        view.addSubview(tableview)
        view.addSubview(spinner)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
        spinner.frame = .init(x: 0, y: 0, width: 80, height: 80)
        spinner.center = view.center
    }
    
    private func addNoNotificationView() {
        tableview.isHidden = true
        notificationView.frame = .init(x: 0, y: 0, width: view.width/2, height: view.width/2)
        notificationView.center = view.center
    }
    

}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text =  "text"
        return cell
    }
    
    
}
