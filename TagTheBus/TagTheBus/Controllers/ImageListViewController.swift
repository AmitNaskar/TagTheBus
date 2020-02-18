//
//  ImageListViewController.swift
//  TagTheBus
//
//  Created by Amit Naskar on 23/11/19.
//  Copyright © 2019 Amit Naskar. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ImageListViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    
    var photoListVM = [PhotoViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoListVM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageListTableViewCell", for: indexPath) as? ImageListTableViewCell else {
            fatalError("ImageListTableViewCell is not found")
        }
        let photoVM = photoListVM[indexPath.row]
        if let image = photoVM.image {
            cell.imgView.image = image
            cell.titleLabel.text = photoVM.title ?? ""
            cell.descLabel.text = photoVM.desc ?? ""
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowPhotoDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navVC = segue.destination as? UINavigationController, let photosCVC = navVC.topViewController as? PhotosCollectionViewController {
            photosCVC.selectedPhoto.subscribe(onNext: { [weak self] photoViewModel in
                self?.photoListVM.append(photoViewModel)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            }).disposed(by: disposeBag)
        }
        
        if let navVC = segue.destination as? UINavigationController, let photosDVC = navVC.topViewController as? PhotoDetailViewController {
            if let indexPath = sender as? IndexPath {
                let photoVM = photoListVM[indexPath.row]
                photosDVC.photoVM = photoVM
            }
        }
    }
}
