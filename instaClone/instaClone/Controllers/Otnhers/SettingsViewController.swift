//
//  SettingsViewController.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//

import UIKit
import SafariServices

///viewcontroller to show user settings
struct SettingsCellModel {
    let title: String
    let handler: () -> Void
}

class SettingsViewController: UIViewController {
    
    private var data: [[SettingsCellModel]] = []
    
    let tableview: UITableView = {
        let tbl = UITableView()
        tbl.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       configureModels()
       setupTableview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
    
    private func setupTableview() {
        tableview.delegate =  self
        tableview.dataSource = self
        view.addSubview(tableview)
    }
    
    //MARK: - configureModels()
    private func configureModels() {
        
       
    data.append([SettingsCellModel(title: "Edit profile"){ [weak self] in
                self?.didtapEditPRofile()
        },
            SettingsCellModel(title: "Invite friends"){ [weak self] in
                self?.didtapInviteFriends()
        },
            SettingsCellModel(title: "Save original posts"){ [weak self] in
                self?.didTapSaveOriginalPost()
                        }
             ])
    data.append([SettingsCellModel(title: "Terms of Service"){ [weak self] in
            self?.openURL(type: .terms)
            },
            SettingsCellModel(title: "Privacy police"){ [weak self] in
            self?.openURL(type: .privacy)
            },
            SettingsCellModel(title: "Help / Feedback"){ [weak self] in
            self?.openURL(type: .help)
                    }
            ])
    data.append([SettingsCellModel(title: "Log out"){ [weak self] in
            self?.didtapLogout()
            }
            ])
    }
    
    //MARK: - didtapLogout()
    private func didtapLogout() {
        let sheet = UIAlertController(title: "Log out",
                                      message: "Are you sure you want to log out",
                                      preferredStyle: .actionSheet)
        sheet.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(.init(title: "Log out", style: .destructive, handler: { _ in
            AuthManager.shared.logOut { succes in
                DispatchQueue.main.async {
                    if succes {
                        //успешный выход из авторизации
                        let vc = LoginViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true) {
                            self.navigationController?.popToRootViewController(animated: true)
                            self.tabBarController?.selectedIndex = 0
                        }
                    } else {
                        //error occured
                    print("Could not log out user")
                  }
               }
            }
        }))
        //настройки для ipad
        sheet.popoverPresentationController?.sourceView =  tableview
        sheet.popoverPresentationController?.sourceRect =  tableview.bounds
        
        self.present(sheet, animated: true, completion: nil)
    }
    
    
    enum SettingsURLType {
        case terms
        case privacy
        case help
    }
    
    private func openURL(type: SettingsURLType) {
        let urlString: String
        switch type {
        case .terms:
            urlString = "https://help.instagram.com/581066165581870"
        case .privacy:
            urlString = "https://help.instagram.com/196883487377501"
        case .help:
            urlString = "https://help.instagram.com/"
        }
        guard let url = URL(string: urlString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    private func didtapEditPRofile() {
        let vc = EditProfileViewController()
        vc.title = "Edit profile"
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    private func didtapInviteFriends() {
        //show share sheet to invite friends
    }
    private func didTapSaveOriginalPost() {
        
    }
}
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
        let model = data[indexPath.section][indexPath.row]
        ///срабатывание функции в кложуре
        model.handler()
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      let v = UIView()
        v.backgroundColor = .systemGray6
        return v
    }
}
