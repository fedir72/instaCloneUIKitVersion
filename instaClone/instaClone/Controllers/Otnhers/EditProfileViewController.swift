//
//  EditProfileViewController.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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

}

private extension EditProfileViewController {
    
    @objc func didtapSave() {
        
    }
    
    @objc func didtapCancel() {
        
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
    
}
