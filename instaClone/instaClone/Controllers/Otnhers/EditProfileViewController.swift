//
//  EditProfileViewController.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//

import UIKit

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
}

final class EditProfileViewController: UIViewController {
    
    private let table: UITableView = {
        let tbl = UITableView()
        tbl.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.id)
        return tbl
    }()
    
    private var models = [[EditProfileFormModel]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModels()
        view.addSubview(table)
        table.tableHeaderView =  createHeaderView()
        table.delegate = self
        table.dataSource = self
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(didtapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didtapSave))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
}

private extension EditProfileViewController {
    
    @objc func didtapSave() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didtapCancel() {
        dismiss(animated: true,completion: nil)
    }
    
    @objc func didtapChangeProfilePicture() {
        let sheet = UIAlertController(title: "Profile picture",
                                      message: "Change profile picture",
                                      preferredStyle: .actionSheet)
        sheet.addAction(.init(title: "take photo", style: .default){ _ in
            
        })
        sheet.addAction(.init(title: "Choose from library", style: .default){ _ in
            
        })
        sheet.addAction(.init(title: "Cancel", style: .cancel) { _ in
            
        })
        sheet.popoverPresentationController?.sourceView =  view
        sheet.popoverPresentationController?.sourceRect = view.bounds
        present(sheet, animated: true)
    }
    
    //MARK: - createHeaderView()
   func createHeaderView() -> UIView {
        let header = UIView(frame: .init(x: 0, y: 0, width: view.width, height: view.width/4).integral)
       let size = header.height/1.5
       let profilePhotoButton = UIButton(frame: .init(x: (view.width-size)/2,
                                                      y: (header.height-size)/2,
                                                      width: size,
                                                      height: size))
       header.addSubview(profilePhotoButton)
       profilePhotoButton.layer.masksToBounds =  true
       profilePhotoButton.layer.cornerRadius = size/2
       profilePhotoButton.tintColor = .label
       profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
       profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"),
                                             for: .normal)
       profilePhotoButton.layer.borderWidth = 1
       profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return header
    }
    
    @objc func didTapProfilePhotoButton() {
        
    }
    
    func configureModels(){
        //name,username,website,bio
        let sectionLabels = ["Name","Username","Bio"]
        var section1 = [EditProfileFormModel]()
        for label in sectionLabels {
            let model = EditProfileFormModel(label: label,
                                             placeholder: "Enter \(label)...",
                                             value: nil)
            section1.append(model)
        }
        models.append(section1)
        //email,phone,gender
        let section2Labels = ["Email","Phone","Gender"]
        var section2 = [EditProfileFormModel]()
        for label in section2Labels {
            let model = EditProfileFormModel(label: label,
                                             placeholder: "Enter \(label)...",
                                             value: nil)
            section2.append(model)
        }
        models.append(section2)
    }
    
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = models[indexPath.section][indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: FormTableViewCell.id,
                                             for: indexPath) as! FormTableViewCell
        cell.configureCell(with: item)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else { return nil}
        return "Private Information"
    }
}

extension EditProfileViewController: FormTableViewCellDelegate {
    
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
//        updatedModel.label
//        //update the model
//        print(updatedModel.value ?? "nil")
    }
    
    
}
