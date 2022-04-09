//
//  ListViewController.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//

import UIKit

class ListViewController: UIViewController {
    
    private var data: [UserRelationShip]
    private let tableView: UITableView = {
        let tbl = UITableView()
        tbl.register(UserFollowTableViewCell.self,
                     forCellReuseIdentifier: UserFollowTableViewCell.id)
        return tbl
    }()
    
    init(data: [UserRelationShip]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        //view.backgroundColor = .red
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
  
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: UserFollowTableViewCell.id,
                                                 for: indexPath) as! UserFollowTableViewCell
        let model = data[indexPath.row]
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = data[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}

//MARK: - UserFollowTableViewCellDelegate
extension ListViewController: UserFollowTableViewCellDelegate {
    func didTapFollowUnfollow(model: UserRelationShip) {
        switch model.type {
            
        case .following:
            //perform firebase update to unfollow
            break
        case .not_following:
            //perform firebase update to follow
            break
        }
    }  
}
