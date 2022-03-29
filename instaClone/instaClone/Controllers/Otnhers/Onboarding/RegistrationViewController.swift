//
//  RegistrationViewController.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    struct  Constant {
        static let cornerRadius: CGFloat = 8
    }
    
    
    //MARK: - properties
    private let usernameField: UITextField = {
        let fld = UITextField()
        fld.placeholder = "Username..."
        fld.returnKeyType = .next
        fld.leftViewMode = .always
        fld.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        fld.autocapitalizationType = .none
        fld.autocorrectionType = .no
        fld.layer.masksToBounds =  true
        fld.layer.cornerRadius = Constant.cornerRadius
        fld.backgroundColor = .secondarySystemBackground
        fld.layer.borderWidth = 1.0
        fld.layer.borderColor = UIColor.secondaryLabel.cgColor
        return fld
    }()
    
    private let emailField: UITextField = {
        let fld = UITextField()
        fld.placeholder = "Email adress..."
        fld.returnKeyType = .next
        fld.leftViewMode = .always
        fld.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        fld.autocapitalizationType = .none
        fld.autocorrectionType = .no
        fld.layer.masksToBounds =  true
        fld.layer.cornerRadius = Constant.cornerRadius
        fld.backgroundColor = .secondarySystemBackground
        fld.layer.borderWidth = 1.0
        fld.layer.borderColor = UIColor.secondaryLabel.cgColor
        return fld
    }()
    
    
    
    private let passwordField: UITextField = {
        let fld = UITextField()
        fld.placeholder = "Password..."
        fld.isSecureTextEntry =  true
        fld.returnKeyType = .continue
        fld.leftViewMode = .always
        fld.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        fld.autocapitalizationType = .none
        fld.autocorrectionType = .no
        fld.layer.masksToBounds =  true
        fld.layer.cornerRadius = Constant.cornerRadius
        fld.backgroundColor = .secondarySystemBackground
        fld.layer.borderWidth = 1.0
        fld.layer.borderColor = UIColor.secondaryLabel.cgColor
        return fld
    }()
    
    private let registerButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Register", for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = Constant.cornerRadius
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .green
        return btn
    }()
    
    //MARK: - life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
          addViews()
        
          usernameField.delegate = self
          emailField.delegate = self
          passwordField.delegate =  self
        
          registerButton.addTarget(self, action: #selector(didtapRegister), for: .touchUpInside)
          view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
          getConstraints()
    }
    
    private func addViews() {
        view.backgroundColor = .systemBlue
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
    }
    
    private func getConstraints() {
        usernameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 100, width: view.width - 40 , height: 50)
        emailField.frame = CGRect(x: 20, y: usernameField.bottom + 10, width: view.width - 40 , height: 50)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 10, width: view.width - 40 , height: 50)
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom + 10, width: view.width - 40 , height: 50)
    }
    
    //MARK: - actions
    
    @objc private func didtapRegister() {
        print("didtap")
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8,
              let name = usernameField.text, !name.isEmpty else { return }
        
        AuthManager.shared.registerNewUser(username: name, email: email, password: password) { registered in
            DispatchQueue.main.async {
                
            
            if registered {
                //good to go
            } else {
                // failed register
                
            }
        }
    }
}
    
}
extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            didtapRegister()
        }
      return true
   }
}
