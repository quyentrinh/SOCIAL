//
//  UserDetailViewController.swift
//  SOCIAL
//
//  Created by Quyen Trinh on 5/8/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import RxDataSources
import SnapKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var imvUserAvatar: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let bag = DisposeBag()
    
    var viewModel : UserDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        bindUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func  setupUI() {
        
        let button = UIButton(type: UIButtonType.custom)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Albums", for: .normal)
        button.rx
            .controlEvent(UIControlEvents.touchUpInside)
            .subscribe(onNext: { [weak self] _ in
                let albumVC = self?.storyboard?.instantiateViewController(withIdentifier: "AlbumsViewController") as! AlbumsViewController
                let albumViewModel = AlbumViewModel(user: (self?.viewModel.user)!)
                albumVC.viewModel = albumViewModel
                self?.navigationController?.pushViewController(albumVC, animated: true)
            })
            .disposed(by: bag)
        
        
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        
        
        
        tableView.tableHeaderView = self.tableHeaderView()
        tableView
            .rx
            .setDelegate(self as UIScrollViewDelegate)
            .disposed(by: bag)
    }

    func tableHeaderView() -> UIView {
        let viewFrame = self.view.frame
        
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: viewFrame.width, height: 180))
        contentView.backgroundColor = .groupTableViewBackground
        
        let avatar = UIImageView()
        avatar.layer.cornerRadius = 60.0
        avatar.clipsToBounds = true
        imvUserAvatar = avatar;
        contentView.addSubview(avatar)
        avatar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 120, height: 120))
            make.centerX.equalToSuperview()
        }
        
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        label.font = UIFont.italicSystemFont(ofSize: 14)
        lblUserName = label
        contentView.addSubview(label)
        label.snp.makeConstraints {make in
            make.top.equalTo(avatar.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        return contentView
    }
    
    func bindUI() {
        
        viewModel
            .user
            .asObservable()
            .map {$0.name}
            .subscribe(onNext: { [weak self] value in
                self?.navigationItem.title = value
            })
            .disposed(by: bag)

        viewModel
            .user
            .asDriver()
            .map {"@\(String(describing: $0.userName!))"}
            .drive(lblUserName.rx.text)
            .disposed(by: bag)
        
        viewModel
            .user
            .asDriver()
            .map { $0.avatarURL }
            .drive(onNext: { [weak self] url in
                self?.imvUserAvatar.kf.setImage(with: URL(string: url))
            })
            .disposed(by: bag)
        
        viewModel
            .postList
            .asObservable()
            .bind(to: tableView.rx.items) { [weak self] tableView, index, event in
                let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
                cell.post = self?.viewModel.postList.value[index]
                return cell
            }
            .disposed(by: bag)
        
        tableView.rx
            .modelSelected(Post.self)
            .subscribe(onNext: { [weak self] model in
                let commentVC = self?.storyboard?.instantiateViewController(withIdentifier: "CommentViewController") as! CommentViewController
                let commentViewModel = CommentViewModel(user: (self?.viewModel.user)!, post: Variable(model))
                commentVC.viewModel = commentViewModel
                self?.navigationController?.pushViewController(commentVC, animated: true)
            })
            .disposed(by: bag)
    }
    
}

extension UserDetailViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        view.backgroundColor = .black
        
        let label = UILabel()
        label.textColor = .white
        label.text = "ALL POST"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        
        return view
    }
}











