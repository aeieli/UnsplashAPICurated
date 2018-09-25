//
//  User.swift
//  UnsplashAPIProject
//
//  Created by lijingjing on 2018/9/21.
//  Copyright © 2018年 aeieli. All rights reserved.
//

import Foundation

struct User: Decodable {
    var userId: String
    var userName: String?
    var protfolioUrl: String?
    
    
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case userName = "username"
        case protfolioUrl = "portfolio_url"
    }

}


// source from:
// https://unsplash.com/documentation#list-curated-photos

    //        "user": {
    //            "id": "pXhwzz1JtQU",
    //            "username": "poorkane",
    //            "name": "Gilbert Kane",
    //            "portfolio_url": "https://theylooklikeeggsorsomething.com/",
    //            "bio": "XO",
    //            "location": "Way out there",
    //            "total_likes": 5,
    //            "total_photos": 74,
    //            "total_collections": 52,
    //            "instagram_username": "instantgrammer",
    //            "twitter_username": "crew",
    //            "profile_image": {
    //                "small": "https://images.unsplash.com/face-springmorning.jpg?q=80&fm=jpg&crop=faces&fit=crop&h=32&w=32",
    //                "medium": "https://images.unsplash.com/face-springmorning.jpg?q=80&fm=jpg&crop=faces&fit=crop&h=64&w=64",
    //                "large": "https://images.unsplash.com/face-springmorning.jpg?q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128"
    //            },
    //            "links": {
    //                "self": "https://api.unsplash.com/users/poorkane",
    //                "html": "https://unsplash.com/poorkane",
    //                "photos": "https://api.unsplash.com/users/poorkane/photos",
    //                "likes": "https://api.unsplash.com/users/poorkane/likes",
    //                "portfolio": "https://api.unsplash.com/users/poorkane/portfolio"
    //            }
