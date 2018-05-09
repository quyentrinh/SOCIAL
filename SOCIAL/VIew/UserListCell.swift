//
//  UserListCell.swift
//  SOCIAL
//
//  Created by Quyen Trinh on 5/8/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import Kingfisher

class UserListCell: UITableViewCell {

    @IBOutlet weak var imvAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!

    var person : Person! {
        didSet {
            guard let _person = person else { return }
            if let url = URL(string: _person.avatarURL) {
                imvAvatar.kf.setImage(with: url)
            }
            lblName.text = _person.name
            lblUserName.text = "@\(String(describing: _person.userName!))"
            lblEmail.text = _person.email
            lblPhoneNumber.text = _person.phone
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
