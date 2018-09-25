//
//  NetwordCenter.swift
//  UnsplashAPIProject
//
//  Created by lijingjing on 2018/9/21.
//  Copyright © 2018年 aeieli. All rights reserved.
//

import Foundation

import Moya

// 网络管理类
let UnsplashProvider = MoyaProvider<UnsplashAPI> ()

// 请求分类
public enum UnsplashAPI {
    case curatedPhotos(Int, Int)
}

// 配置请求行为
extension UnsplashAPI: TargetType {
    //URL
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: "https://api.unsplash.com")!
        }
    }
    
    //请求路径
    public var path: String {
        switch self {
        case .curatedPhotos(_, _):
            return "/photos/curated"
        }
    }
    
    //选择请求方法
    public var method: Moya.Method {
        switch self {
        case .curatedPhotos(_, _):
            return .get
        }
    }
    
    public var task: Task {
        var params: [String: Any] = [:]
        params["client_id"] = "29e58b41e34c8ce8c8ac7ef32588bbe27bbc5ebe17c38bd13f106b1288d4ddc2"
        switch self {
        case .curatedPhotos(let page, let limit):
            params["page"] = page
            params["per_page"] = limit
            params["order_by"]  = "popular"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    public var validate: Bool {
        return false
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    //请求头
    public var headers: [String: String]? {
        return nil
    }
}


//class NetworkCenter {
//    let baseUrl = "https://api.unsplash.com/"
//
//    public func Post (url: String) {
//        Alamofire.request(baseUrl + url).responseJSON { response in
//            debugPrint(response)
//
//            if let json = response.result.value {
//                print("JSON: \(json)")
//            }
//        }
//
////        /photos/curated
//    }
//}
