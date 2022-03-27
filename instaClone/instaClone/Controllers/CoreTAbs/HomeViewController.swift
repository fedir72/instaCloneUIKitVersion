//
//  Main
//  HomeViewController.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //MARK: - check auth status
        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            //Show login
            let lvc = LoginViewController()
            lvc.modalPresentationStyle = .fullScreen
            present(lvc, animated:  false)
        }
    }


}

