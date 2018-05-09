//
//  GalleryCell.swift
//  SOCIAL
//
//  Created by Quyen Trinh on 5/9/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import Kingfisher

class GalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var imvPhoto: UIImageView!
    
    var photo : Photo! {
        didSet {
            guard let _photo = photo else { return }
            if let url = URL(string: _photo.thumbnailUrl!) {
                imvPhoto.kf.setImage(with: url)
            }
        }
    }
    
    
}
