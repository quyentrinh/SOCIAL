//
//  PostCell.swift
//  SOCIAL
//
//  Created by Quyen Trinh on 5/8/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    
    var post : Post! {
        didSet {
            guard let _post = post else { return }
            lblTitle.text = _post.title
            lblContent.text = _post.body
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblTitle.preferredMaxLayoutWidth = self.lblTitle.frame.size.width
        self.lblContent.preferredMaxLayoutWidth = self.lblContent.frame.size.width
        self.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
