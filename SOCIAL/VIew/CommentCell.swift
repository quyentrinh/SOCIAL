//
//  CommentCell.swift
//  SOCIAL
//
//  Created by Quyen Trinh on 5/9/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var imvUserAvatar: UIImageView!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblUserComment: UILabel!
    
    var comment : Comment! {
        didSet {
            guard let _comment = comment else { return }
            if let url = URL(string: _comment.avatarURL) {
                imvUserAvatar.kf.setImage(with: url)
            }
            lblUserEmail.text = _comment.email
            lblUserComment.text = _comment.body
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
