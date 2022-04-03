//
//  StorageManager.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//

import FirebaseStorage


class StorageManager {
    static let shared = StorageManager()
    private let bucket = Storage.storage().reference()
    
    public func uploadUserPost(model: UserPost,
                                    completion: (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL,IGStorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL { url, err in
            guard let url = url , err == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        }
        
    }
 }
