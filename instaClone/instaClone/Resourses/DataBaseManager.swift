//
//  DataBaseManager.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//

//import Foundation
import FirebaseDatabase

class DatabaseManager {
    
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    //MARK: - Public func
    /**
     -Check if username and email is available
     -Parameters
     -email: Stringrepresenting email
     -username: Stringrepresenting username
     **/
   
    
    public func canCreateNewUser(with email: String, username: String, completion: @escaping (Bool)->()) {
        completion(true)
    }
    /// insert new user to database
    /// parameters
    /// email: stringrepresenting email
    ///-username: Stringrepresenting username
    /// -completion: async callback for result if database entry succeded
     
      public func insertNewUser(with email: String, username: String,completion: @escaping (Bool) -> Void) {
          let key = email.safeDatabaseKey()
          print(key)
          database.child(key).setValue(["username": username]){ error, _ in
            if error == nil {
                //succes
                completion(true)
                return
            }else{
                //failed
                completion(false)
                return
            }
        }
    }
    //MARK: - private
}
