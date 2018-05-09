//
//  UserDetailViewModel.swift
//  SOCIAL
//
//  Created by Quyen Trinh on 5/8/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Moya
import ObjectMapper

class UserDetailViewModel {

    let bag = DisposeBag()
    
    // MARK: - Input
    var user : Variable<Person>
    var postList : Variable<[Post]>
    
    init(user : Variable<Person>) {
        self.user = user
        self.postList = Variable<[Post]>([])
        
        bindOutput()
    }
    
    // MARK: - Output
    func bindOutput() {

        user
            .asObservable()
            .map {$0.id}
            .flatMap { (userID) -> Single<Response> in
                return APIProvider.shared.getPostfromUser(id: userID)
            }.subscribe(onNext: { [unowned self] response in
                let json = try? response.mapJSON()
                guard let posts = json as? Array<[String: Any]> else {return}
                var result = Array<Post>()
                for _post in posts {
                    let post = Post(JSON: _post)
                    result.append(post!)
                }
                self.postList.value = result
            }).disposed(by: bag)

    }

}
