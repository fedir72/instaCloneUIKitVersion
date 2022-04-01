//
//  StorageManager.swift
//  instaClone
//
//  Created by Fedii Ihor on 26.03.2022.
//

import FirebaseStorage

public struct PhotoPost {
    let postType: UserPostType
}

public enum UserPostType {
    case photo
    case video
}

public enum IGStorageManagerError: Error {
    case failedToDownload
}

class StorageManager {
    static let shared = StorageManager()
    private let bucket = Storage.storage().reference()
    
    public func uploadUserPost(model: PhotoPost,
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
