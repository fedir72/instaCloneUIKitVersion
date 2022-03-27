//
//  LoginViewController.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    //MARK: - constants
    struct Constant {
        static let cornerradius: CGFloat = 8.0
    }
    
    //MARK: - properties
    private let usernameTextField: UITextField = {
        let fld = UITextField()
        fld.placeholder = "Username or email"
        fld.returnKeyType = .next
        fld.leftViewMode = .always
        fld.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        fld.autocapitalizationType = .none
        fld.autocorrectionType = .no
        fld.layer.masksToBounds =  true
        fld.layer.cornerRadius = Constant.cornerradius
        fld.backgroundColor = .secondarySystemBackground
        fld.layer.borderWidth = 1.0
        fld.layer.borderColor = UIColor.secondaryLabel.cgColor
        return fld
    }()
    
    private let passwordTextField: UITextField = {
        let fld = UITextField()
        fld.placeholder = "Password..."
        fld.returnKeyType = .continue
        fld.leftViewMode = .always
        fld.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        fld.autocapitalizationType = .none
        fld.autocorrectionType = .no
        fld.layer.masksToBounds =  true
        fld.layer.cornerRadius = Constant.cornerradius
        fld.backgroundColor = .secondarySystemBackground
        fld.layer.borderWidth = 1.0
        fld.layer.borderColor = UIColor.secondaryLabel.cgColor
        return fld
    }()
    
    private let loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Log in", for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = Constant.cornerradius
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        return btn
    }()
    
    private let termsButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Terms of serviced", for: .normal)
        btn.setTitleColor(.secondaryLabel, for: .normal)
        return btn
    }()
    
    private let privacyButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Privacy Polisy", for: .normal)
        btn.setTitleColor(.secondaryLabel, for: .normal)
        return btn
    }()
    
    private let createAccountButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.label, for: .normal)
        btn.setTitle("New user? Create an account", for: .normal)
        //btn.backgroundColor = .systemGray6
        return btn
    }()
    
    private let headerView: UIView = {
        let v = UIView()
        v.clipsToBounds = true
        let grd = UIImage(named: "gradient")
        let grdv = UIImageView(image: grd)
        v.addSubview(grdv)
       return v
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        passwordTextField.delegate =  self
        view.backgroundColor = .systemBackground
        addSubviews()
        
        loginButton.addTarget(self,
                              action: #selector(didTapLoginButton),
                              for: .touchUpInside)
        createAccountButton.addTarget(self,
                                      action: #selector(didTapcreateAccountButton),
                                      for: .touchUpInside)
        termsButton.addTarget(self,
                              action: #selector(didTapTermsButton),
                              for: .touchUpInside)
        privacyButton.addTarget(self,
                                action: #selector(didTapPrivacyButton),
                                for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //assignConstraints
        headerView.frame = CGRect(x: 0,
                                  y: 0 ,
                                  width: view.width,
                                  height: view.height/3)
        usernameTextField.frame =  CGRect(x: 25,
                                          y: headerView.bottom + 10,
                                          width: view.width - 50,
                                          height: 52)
        
        passwordTextField.frame = CGRect(x: 25,
                                         y: usernameTextField.bottom + 10,
                                         width: view.width - 50,
                                         height: 52)
        loginButton.frame = CGRect(x: 25,
                                   y: passwordTextField.bottom + 10,
                                   width: view.width - 50,
                                   height: 52)
        
        createAccountButton.frame = CGRect(x: 25,
                                           y: loginButton.bottom + 10,
                                           width: view.width - 50,
                                           height: 52)
        termsButton.frame = CGRect(x: 10,
                                   y: view.height - view.safeAreaInsets.bottom - 100,
                                   width: view.width - 20,
                                   height: 50)
        
        privacyButton.frame = CGRect(x: 10,
                                     y: view.height - view.safeAreaInsets.bottom - 50,
                                     width: view.width - 20,
                                     height: 50)
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        
        guard headerView.subviews.count == 1 else {return}
        guard let bacgroundView = headerView.subviews.first else {return}
        bacgroundView.frame = headerView.bounds
        //add instagram logo
        let logoView = UIImageView(image: UIImage(named: "instaLogo"))
        headerView.addSubview(logoView)
        logoView.contentMode = .scaleAspectFit
        logoView.frame = CGRect(x: headerView.width/4.0,
                                y: view.safeAreaInsets.top,
                                width: headerView.width/2 ,
                                height: headerView.width - view.safeAreaInsets.top)
    }
    
    func addSubviews() {
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(privacyButton)
        view.addSubview(termsButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
    }
    
    @objc private func didTapLoginButton() {
        passwordTextField.resignFirstResponder()
        usernameTextField.resignFirstResponder()
        guard let usernameEmail = usernameTextField.text, !usernameEmail.isEmpty,
              let pass = passwordTextField.text, !pass.isEmpty, pass.count >= 8 else {
            return
        }
        //login functionality
    }
    @objc private func didTapTermsButton() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/196883487377501") else {return}
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    @objc private func didTapcreateAccountButton() {
        let vc = RegistrationViewController()
        present(vc, animated: true, completion: nil)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            didTapLoginButton()
        }
        return true
    }
}
