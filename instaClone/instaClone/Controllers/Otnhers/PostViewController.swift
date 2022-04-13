//
//  PostViewController.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//

import UIKit

/*
 Section: Header Model
 Section: PostCell model
 Section: ActionButton Cell model
 Section: -n Number of general models for comments
 */

///States of a render cell
enum PostRenderType {
    case header(provider: User)
    case primaryContent(provider: UserPost) //post
    case actions(provider: String)       //like, comment, share
    case comments(comments: [PostComment])
}

///Model of rendered posts
struct PostRenderViewModel {
     let renderType: PostRenderType
}

class PostViewController: UIViewController {
    
    //MARK: - properties
    private let model: UserPost?
    private var renderModels = [PostRenderViewModel]()
    
    private let tableview: UITableView = {
        let table = UITableView()
        //header
        table.register(IGFeedPostHeaderTableViewCell.self,
                       forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.id)
        //cells
        table.register(IGFeedPostTableViewCell.self,
                       forCellReuseIdentifier: IGFeedPostTableViewCell.id)
        table.register(IGfeedPostActionsTableViewCell.self,
                       forCellReuseIdentifier: IGfeedPostActionsTableViewCell.id)
        table.register(IGFeedPostGeneralTableViewCell.self,
                       forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.id)
        return table
    }()
    
    //MARK: - init
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        view.addSubview(tableview)
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
    
    //Mock data for controller
    private func configureModels() {
        guard let userpostModel = self.model else { return }
         //header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userpostModel.owner)))
         //post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userpostModel)))
         //actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
         //comments
        var comments = [PostComment]()
                            for x in 1...4 {
            comments.append(PostComment(identifier: "123_\(x)",
                                        userName: "@dave",
                                        text: "Great post",
                                        createdDate: Date(),
                                        likes: []))
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
  }
}
                            

//MARK: - UITableViewDelegate, UITableViewDataSource
extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        renderModels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
            
        case .header(_):
            return 1
        case .primaryContent(_):
            return 1
        case .actions(_):
            return 1
        case .comments(let comments):
            return comments.count > 4 ? 4 : comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        switch model.renderType {
            
        case .header(provider: let provider):
            let cell = tableview.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.id,
                                                     for: indexPath) as! IGFeedPostHeaderTableViewCell
            return cell
        case .primaryContent(provider: let provider):
            let cell = tableview.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.id,
                                                     for: indexPath) as! IGFeedPostTableViewCell
            return cell
        case .actions(provider: let provider):
            let cell = tableview.dequeueReusableCell(withIdentifier: IGfeedPostActionsTableViewCell.id,
                                                     for: indexPath) as! IGfeedPostActionsTableViewCell
            return cell
        case .comments(comments: let comments):
            let cell = tableview.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.id,
                                                     for: indexPath) as! IGFeedPostGeneralTableViewCell
            cell.configure()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .header(_): return 70
        case .primaryContent(_): return tableview.width
        case .actions(_): return 60
        case .comments(_): return 50
        }
    }
    
}
