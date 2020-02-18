//
//  PhotosCollectionViewController.swift
//  TagTheBus
//
//  Created by Amit Naskar on 23/11/19.
//  Copyright © 2019 Amit Naskar. All rights reserved.
//

import Foundation
import UIKit
import Photos
import RxSwift

class PhotosCollectionViewController: UICollectionViewController {
    
    private let selectedPhotoSubject = PublishSubject<PhotoViewModel>()
    var selectedPhoto: Observable<PhotoViewModel> {
        return selectedPhotoSubject.asObservable()
    }
    let disposeBag = DisposeBag()
    
    private var images = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populatePhotos()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedAsset = self.images[indexPath.row]
        PHImageManager.default().requestImage(for: selectedAsset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: nil) { [weak self] image, info in
            
            guard let info = info else { return }
            
            let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
            
            if !isDegradedImage {
                
                if let image = image {
                    DispatchQueue.main.async {
                        self?.showAlert(image: image)
                    }
                }
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("PhotoCollectionViewCell is not found")
        }
        
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { image, _ in
            
            DispatchQueue.main.async {
                cell.photoImageView.image = image
            }
        }
        return cell
    }
    
    // MARK : IBActions
    
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK : Private Methods
    
    private func populatePhotos() {
        
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            
            if status == .authorized {
                
                // access the photos from photo library
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                
                assets.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
                
                self?.images.reverse()
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    private func showAlert(image: UIImage) {
        var alertTitleText: String?
        var alertDescText: String?
        
        let alertController: UIAlertController = UIAlertController(title: "Please provide a title with a short description!", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Title"
            textField.rx.controlEvent(.editingDidEnd)
                .asObservable()
                .map {textField.text }
                .subscribe(onNext: { title in
                    alertTitleText = title ?? ""
                }).disposed(by: self.disposeBag)
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Description"
            textField.rx.controlEvent(.editingDidEnd)
                .asObservable()
                .map {textField.text }
                .subscribe(onNext: { desc in
                    alertDescText = desc ?? ""
                }).disposed(by: self.disposeBag)
            
        }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let photo = Photo(image: image, title: alertTitleText, desc: alertDescText)
            
            let photoViewModel = PhotoViewModel(photo)
            self.selectedPhotoSubject.onNext(photoViewModel)
            
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
