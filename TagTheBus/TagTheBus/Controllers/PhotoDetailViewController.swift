//
//  PhotoDetailViewController.swift
//  TagTheBus
//
//  Created by Amit Naskar on 23/11/19.
//  Copyright © 2019 Amit Naskar. All rights reserved.
//

import Foundation
import UIKit

class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var descriptionText: UITextView!
    
    var photoVM: PhotoViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = photoVM?.photo?.image, let title = photoVM?.photo?.title, let desc = photoVM?.photo?.desc {
            self.title = title
            detailImageView.image = image
            descriptionText.text = desc
        }
    }
    
    // MARK : IBActions
    
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButtonAction(_ sender: UIBarButtonItem) {
        if let image = photoVM?.photo?.image, let title = photoVM?.photo?.title, let desc = photoVM?.photo?.desc {
            let vc = UIActivityViewController(activityItems: [image, title, desc], applicationActivities: [])
            present(vc, animated: true)
        }
    }
}
