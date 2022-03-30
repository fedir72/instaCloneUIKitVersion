//
//  SettingsViewController.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//

import UIKit

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
    
    private func configureModels() {
        let section = [SettingsCellModel(title: "Log out", handler: { [weak self] in
            self?.didtapLogout()
        })]
        data.append(section)
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
        let model = data[indexPath.section][indexPath.row]
        ///срабатывание функции в кложуре
        model.handler()
        
    }
}
