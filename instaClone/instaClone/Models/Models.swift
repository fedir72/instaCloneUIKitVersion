//
//  Models.swift
//  instaClone
//
//  Created by Fedii Ihor on 03.04.2022.
//

import Foundation

enum Gender {
    case male
    case female
    case other
}

struct UserCount {
    var folowers: Int
    var following: Int
    var posts: Int
}

public struct User{
    let userNAme: String
    let bio: String
    let name: (first: String, second: String)
    let birdthdate: Date
    let gender: Gender
    var counts: UserCount
    let joinedDate: Date
    let profilePhoto: URL
}

public struct UserPost {
    let identifire: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postUrl: URL //ether video url or full resolution photo
    let caption: String?
    let likeCount: [Like]
    let comments: [PostComment]
    let createdDate: Date
    let taggedusers: [String]
}

public struct PostComment {
    let identifier: String
    let userName: String
    let text: String
    let createdDate: Date
    var likes: [CommentLike]
}

public struct Like {
    let username: String
    let postIdentifire: String
}

public struct CommentLike {
    let username: String
    let commentIdentifire: String
}

public enum UserPostType {
    case photo
    case video
}

public enum IGStorageManagerError: Error {
    case failedToDownload
}
