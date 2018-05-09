//
//  APIProvider.swift
//  SOCIAL
//
//  Created by Quyen Trinh on 5/9/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa

class APIProvider {
    
    static let shared = APIProvider()
    
    let provider : MoyaProvider<SocialService>
    
    private init() {
        provider = MoyaProvider<SocialService>()
    }
    
    //MARK: -Public method
    
    func getUserList() -> Single<Response> {
        return provider.rx.request(.user)
    }
    
    func getPostfromUser(id: Int) -> Single<Response> {
        return provider.rx.request(.post(userId: id))
    }
    
    func getCommenfromPost(id: Int) -> Single<Response> {
        return provider.rx.request(.comment(postId: id))
    }
    
    func getAlbumfromUser(id: Int) -> Single<Response> {
        return provider.rx.request(.album(userId: id))
    }
    
    func getPhotosfromAlbum(id: Int) -> Single<Response> {
        return provider.rx.request(.photo(albumId: id))
    }
    
}

enum SocialService {
    case user                                       //https://jsonplaceholder.typicode.com/users
    case post(userId: Int)                          //https://jsonplaceholder.typicode.com/posts?userId=2
    case comment(postId: Int)                       //https://jsonplaceholder.typicode.com/comments?postId=1
    case album(userId: Int)                         //https://jsonplaceholder.typicode.com/albums?userId=1
    case photo(albumId: Int)                        //https://jsonplaceholder.typicode.com/photos?albumId=1
}

extension SocialService : TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .user:
            return "/users"
        case .post:
            return "/posts"
        case .comment:
            return "/comments"
        case .album:
            return "/albums"
        case .photo:
            return "/photos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "SampleData".data(using: .utf8)!
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .post(let userId):
            return ["userId": userId]
        case .comment(let postId):
            return ["postId": postId]
        case .album(let userId):
            return ["userId": userId]
        case .photo(let albumId):
            return ["albumId": albumId]
        default:
            return [:]
        }
    }
    
    public var task: Task {
        switch self {
        case .post, .comment, .album, .photo:
            return .requestParameters(parameters: self.parameters ?? [String: Any](), encoding: URLEncoding.queryString)
        default:
            switch self.method {
            case .post, .put:
                return .requestParameters(parameters: self.parameters ?? [String: Any](), encoding: JSONEncoding.default)
            default:
                return .requestPlain
            }
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

