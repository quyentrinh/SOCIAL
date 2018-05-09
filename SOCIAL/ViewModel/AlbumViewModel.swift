//
//  AlbumViewModel.swift
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

class AlbumViewModel {

    let bag = DisposeBag()
    
    var user : Variable<Person>
    var albumList : Variable<[Album]>
    
    init(user: Variable<Person>) {
        self.user = user
        self.albumList = Variable<[Album]>([])
        
        bindOutput()
    }
    
    // MARK: - Output
    
    func bindOutput()  {
        user
            .asObservable()
            .map{$0.id}
            .flatMap { userID in
                return APIProvider.shared.getAlbumfromUser(id: userID)
            }.subscribe(onNext: { [unowned self] response in
                let json = try? response.mapJSON()
                guard let albums = json as? Array<[String: Any]> else {return}
                var result = Array<Album>()
                for _album in albums {
                    let album = Album(JSON: _album)
                    result.append(album!)
                }
                self.albumList.value = result
            }).disposed(by: bag)
    }
}
