//
//  CommentViewModel.swift
//  SOCIAL
//
//  Created by Quyen Trinh on 5/9/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya
import ObjectMapper

class CommentViewModel {
    // MARK: - Input
    
    let bag = DisposeBag()
    
    var post : Variable<Post>
    var user : Variable<Person>
    var commentList : Variable<[Comment]>
    
    init(user: Variable<Person>, post : Variable<Post>) {
        self.post = post
        self.user = user
        self.commentList = Variable<[Comment]>([])
        
        bindOutput()
    }
    
    // MARK: - Output
    
    func bindOutput()  {
        post
            .asObservable()
            .map{$0.id}
            .flatMap { postId in
                return APIProvider.shared.getCommenfromPost(id: postId)
            }.subscribe(onNext: { [unowned self] response in
                let json = try? response.mapJSON()
                guard let comments = json as? Array<[String: Any]> else {return}
                var result = Array<Comment>()
                for _comment in comments {
                    let comment = Comment(JSON: _comment)
                    result.append(comment!)
                }
                self.commentList.value = result
            }).disposed(by: bag)
    }
}
