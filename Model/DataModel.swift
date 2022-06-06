//
//  DataModel.swift
//  PostsNew
//
//  Created by Анна Тибекина on 17.03.2022.
//

import Foundation

class DataModel {
    
    var posts: [Post] = []
    
    var expandedPosts: [Int] = []

    func sortPostsById(){
        posts.sort { post1, post2 in
            return post1.postId < post2.postId
        }
    }
    
    func sortPostsByRating(ascending: Bool){
        posts.sort { post1, post2 in
            if ascending {
                return post1.likes_count < post2.likes_count
            } else {
                return post1.likes_count > post2.likes_count
            }
        }
    }
    
    func sortPostsByDate(ascending: Bool) {
        posts.sort { post1, post2 in
            if ascending {
                return post1.timeshamp ?? 0 < post2.timeshamp ?? 0
            } else {
                return post1.timeshamp ?? 0 > post2.timeshamp ?? 0
            }
        }
    }
}
