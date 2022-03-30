//
//  AuthManager.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    static let shared = AuthManager()
    //MARK: - Public func
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        
         //Check if username is available
         //-Check if email is available
        
        
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                //-Create account
                //-Insert account to database
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil  else {
                        //firebase auth couldn't create account
                        completion(false)
                        return
                    }
                    //insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username) { succes in
                        if succes {
                            completion(true)
                            return
                        }else{
                            //failed to insert to database
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                //either username or email does not exist
               completion(false)
            }
        }
    }
    public func loginUser(userName: String?, email: String?, password: String, completion: @escaping ((Bool) -> ())) {
        if let email = email {
            //email login
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
         else if let userName = userName {
            //username log in
             print(userName)
        }
    }
    
    //attemt to log firebase user
    public func logOut(completion: (Bool) -> Void ) {
        do {
            try Auth.auth().signOut()//выйти из авторизации
            completion(true)
            return
        } catch {
            completion(false)
            print(error)
            return
        }
    }
        
}
