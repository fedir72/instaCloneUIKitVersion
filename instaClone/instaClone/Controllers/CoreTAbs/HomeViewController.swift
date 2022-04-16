//
//  Main
//  HomeViewController.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel ]()
    
    private let tableView: UITableView = {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate =  self
        tableView.dataSource = self
        createMockModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //MARK: - check auth status
        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            //Show login
            //если юзер нил показать логин контроллер
            let lvc = LoginViewController()
            lvc.modalPresentationStyle = .fullScreen
            present(lvc, animated:  false)
        }
    }
    
    private func createMockModels() {
        let user = User(userNAme: "Joe", bio: "Bio",
                    name: (first: "Joe", second: "Smith"),
                    birdthdate: Date(),
                    gender: .male,
                    counts: UserCount(folowers: 10,
                                      following: 10,
                                      posts: 111),
                    joinedDate: Date(),
                    profilePhoto: URL(string: "https://www.google.com/")!)
        let post = UserPost(identifire: "",
                            postType: .photo,
                            thumbnailImage: URL(string: "https://www.google.com/")!,
                            postUrl: URL(string: "https://www.google.com/")!,
                            caption: nil,
                            likeCount: [],
                            comments: [],
                            createdDate: Date(),
                            taggedusers: [],
                            owner: user)
        var comments = [PostComment]()
        for x in 0...2 {
            comments.append(.init(identifier: "id: \(x)",
                                  userName: "@Jenny",
                                  text: "this is the best post",
                                  createdDate: Date(),
                                  likes: []))
        }
        for _ in 0...5 {
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
            post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
            actions: PostRenderViewModel(renderType: .actions(provider: "actions")),
            comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewModel)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let x = section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x/4 : ((x-(x%4))/4)
            model = feedRenderModels[position]
        }
        
        let subsection = x%4
        if subsection == 0 {
            //header
            return 1
        } else if subsection == 1 {
            //post
            return 1
        }else if subsection == 2 {
            //action
            return 1
        }else if subsection == 3 {
            //comments
            let comentModel = model.comments
            switch comentModel.renderType {
            case .header,.actions,.primaryContent: return 0
            case .comments(comments: let comments):
                return comments.count > 2 ? 2 : comments.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x/4 : ((x-(x%4))/4)
            model = feedRenderModels[position]
        }
        
        let subsection = x%4
        if subsection == 0 {
            //header
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.id,
                                                         for: indexPath) as! IGFeedPostHeaderTableViewCell
                return cell
            case .comments,.actions,.primaryContent: return UITableViewCell()
            }
        } else if subsection == 1 {
            //post
            switch model.post.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.id,
                                                         for: indexPath) as! IGFeedPostTableViewCell
                return cell
            case .comments,.actions,.header: return UITableViewCell()
            }
        }else if subsection == 2 {
            //action
            switch model.actions.renderType {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGfeedPostActionsTableViewCell.id,
                                                         for: indexPath) as! IGfeedPostActionsTableViewCell
                return cell
            case .comments,.header,.primaryContent: return UITableViewCell()
            }
        }else if subsection == 3 {
            //comments
            let commentModel = model.comments
            switch commentModel.renderType {
            
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.id,
                                                         for: indexPath) as! IGFeedPostGeneralTableViewCell
                cell.configure()
                return cell
            case .header,.actions,.primaryContent: return UITableViewCell()
            }
        }
      return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subsection = indexPath.section%4
        if subsection == 0 {
            //header
             return 70
        } else if subsection == 1 {
            //post
            return tableView.width
        } else if subsection == 2 {
            //actions(like/comments)
            return 60
        }else if subsection == 3 {
            //comment row
            return 50
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subsection = section%4
        return subsection == 3 ? 70 : 0
    }
}
