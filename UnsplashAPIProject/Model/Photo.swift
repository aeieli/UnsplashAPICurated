//
//  Photos.swift
//  UnsplashAPIProject
//
//  Created by lijingjing on 2018/9/21.
//  Copyright © 2018年 aeieli. All rights reserved.
//
// https://unsplash.com/documentation#list-curated-photos

import Foundation

struct UrlList: Decodable {
    var thumbUrl: String
    var fullUrl: String
    var regularUrl: String
    var smallUrl: String
    var rawUrl: String
    
    enum CodingKeys: String, CodingKey {
        case rawUrl = "raw"
        case fullUrl = "full"
        case regularUrl = "regular"
        case smallUrl = "small"
        case thumbUrl = "thumb"
    }
}

struct LinkUrlList: Decodable {
    var linkToSelfUrl: String
    var htmlUrl: String
    var downloadUrl: String
    var localDownloadUrl: String
    
    enum CodingKeys: String, CodingKey {
        case linkToSelfUrl = "self"
        case htmlUrl = "html"
        case downloadUrl = "download"
        case localDownloadUrl = "download_location"
    }

}

struct Photo: Decodable {
    var photoId: String
    var createdAt: Date
    var width: Int
    var height: Int
    var color: String?
    var descri: String?
    var user: User?
    var urls: UrlList
    var links: LinkUrlList
    
    enum CodingKeys: String, CodingKey {
        case photoId = "id"
        case createdAt = "created_at"
        case width
        case height
        case color
        case descri = "description"
        case user
        case urls
        case links

    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        photoId = try values.decode(String.self, forKey: .photoId)
        width = try values.decode(Int.self, forKey: .width)
        height = try values.decode(Int.self, forKey: .height)
        color = try values.decode(String.self, forKey: .color)
        user = try values.decode(User.self, forKey: .user)
        links = try values.decode(LinkUrlList.self, forKey: .links)
        urls = try values.decode(UrlList.self, forKey: .urls)
        descri = try values.decode(String.self, forKey: CodingKeys.descri)
        createdAt = try values.decode(Date.self, forKey: .createdAt)

    }

}

// source from:
// https://unsplash.com/documentation#list-curated-photos

//[
//    {
//        "id": "LBI7cgq3pbM",
//        "created_at": "2016-05-03T11:00:28-04:00",
//        "updated_at": "2016-07-10T11:00:01-05:00",
//        "width": 5245,
//        "height": 3497,
//        "color": "#60544D",
//        "likes": 12,
//        "liked_by_user": false,
//        "description": "A man drinking a coffee.",
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
//        },
//        "current_user_collections": [ // The *current user's* collections that this photo belongs to.
//        {
//        "id": 206,
//        "title": "Makers: Cat and Ben",
//        "published_at": "2016-01-12T18:16:09-05:00",
//        "updated_at": "2016-07-10T11:00:01-05:00",
//        "curated": false,
//        "cover_photo": null,
//        "user": null
//        },
//        // ... more collections
//        ],
//        "urls": {
//            "raw": "https://images.unsplash.com/face-springmorning.jpg",
//            "full": "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg",
//            "regular": "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg&w=1080&fit=max",
//            "small": "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg&w=400&fit=max",
//            "thumb": "https://images.unsplash.com/face-springmorning.jpg?q=75&fm=jpg&w=200&fit=max"
//        },
//        "links": {
//            "self": "https://api.unsplash.com/photos/LBI7cgq3pbM",
//            "html": "https://unsplash.com/photos/LBI7cgq3pbM",
//            "download": "https://unsplash.com/photos/LBI7cgq3pbM/download",
//            "download_location": "https://api.unsplash.com/photos/LBI7cgq3pbM/download"
//        }
//    },
//    // ... more photos
//]

