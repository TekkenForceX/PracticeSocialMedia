//
//  Post.swift
//  PracticeSocialMedia
//
//  Created by Matthew Fails on 7/23/25.
//

import Foundation

struct Post: Identifiable {
    let id = UUID()
    let username: String
    let userProfileImage: String // systemName or asset
    let postImage: String        // systemName or asset
    let caption: String
    var isLiked: Bool = false
}
