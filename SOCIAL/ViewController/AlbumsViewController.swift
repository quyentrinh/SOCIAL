//
//  AlbumsViewController.swift
//  SOCIAL
//
//  Created by Quyen Trinh on 5/9/18.
//  Copyright © 2018 Quyen Trinh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AlbumsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let bag = DisposeBag()
    var viewModel : AlbumViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func bindUI() {
        viewModel
            .user
            .asObservable()
            .map {"\($0.name ?? "User")'s Albums"}
            .subscribe(onNext: { [weak self] value in
                self?.navigationItem.title = value
            })
            .disposed(by: bag)
        
        viewModel
            .albumList
            .asObservable()
            .bind(to: tableView.rx.items) { [weak self] tableView, index, event in
                let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell") as! AlbumCell
                cell.album = self?.viewModel.albumList.value[index]
                return cell
            }
            .disposed(by: bag)
        
        tableView.rx
            .modelSelected(Album.self)
            .subscribe(onNext: { [weak self] model in
                let galleryVC = self?.storyboard?.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
                let galleryViewModel = GalleryViewModel(album: Variable(model))
                galleryVC.viewModel = galleryViewModel
                self?.navigationController?.pushViewController(galleryVC, animated: true)
            })
            .disposed(by: bag)
        
    }
    

}
