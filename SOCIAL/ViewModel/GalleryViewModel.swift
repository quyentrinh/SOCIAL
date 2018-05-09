//
//  GalleryViewModel.swift
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

class GalleryViewModel {
    
    let bag = DisposeBag()
    
    var album : Variable<Album>
    var photoList : Variable<[Photo]>
    
    init(album: Variable<Album>) {
        self.album = album
        self.photoList = Variable<[Photo]>([])
        
        bindOutput()
    }
    
    // MARK: - Out
    
    // MARK: - Output
    
    func bindOutput()  {
        album
            .asObservable()
            .map{$0.id}
            .flatMap { albumId in
                return APIProvider.shared.getPhotosfromAlbum(id: albumId)
            }.subscribe(onNext: { [unowned self] response in
                let json = try? response.mapJSON()
                guard let photos = json as? Array<[String: Any]> else {return}
                var result = Array<Photo>()
                for _photo in photos {
                    let photo = Photo(JSON: _photo)
                    result.append(photo!)
                }
                self.photoList.value = result
            }).disposed(by: bag)
    }
}
