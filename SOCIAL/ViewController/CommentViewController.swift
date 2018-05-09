//
//  CommentViewController.swift
//  SOCIAL
//
//  Created by Quyen Trinh on 5/9/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class CommentViewController: UIViewController {

    @IBOutlet weak var imvUserAvatar: UIImageView!
    @IBOutlet weak var lblUserFullName: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblPostTitle: UILabel!
    @IBOutlet weak var lblPostContent: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let bag = DisposeBag()
    var viewModel : CommentViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Comment"
        
        bindUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func bindUI() {
        
        viewModel
            .user
            .asDriver()
            .map {$0.avatarURL}
            .drive(onNext: { [weak self] url in
                self?.imvUserAvatar.kf.setImage(with: URL(string: url))
            })
            .disposed(by: bag)
        
        viewModel
            .user
            .asDriver()
            .map {$0.name}
            .drive(lblUserFullName.rx.text)
            .disposed(by: bag)
        
        viewModel
            .user
            .asDriver()
            .map {"@\(String(describing: $0.userName!))"}
            .drive(lblUserName.rx.text)
            .disposed(by: bag)
        
        viewModel
            .post
            .asDriver()
            .map {$0.title}
            .drive(lblPostTitle.rx.text)
            .disposed(by: bag)
        
        viewModel
            .post
            .asDriver()
            .map {$0.body}
            .drive(lblPostContent.rx.text)
            .disposed(by: bag)
        
        viewModel
            .commentList
            .asObservable()
            .bind(to: tableView.rx.items) { [weak self] tableView, index, event in
                let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
                cell.comment = self?.viewModel.commentList.value[index]
                return cell
            }
            .disposed(by: bag)
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
