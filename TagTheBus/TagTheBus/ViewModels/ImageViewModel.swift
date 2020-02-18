//
//  ImageViewModel.swift
//  TagTheBus
//
//  Created by Amit Naskar on 23/11/19.
//  Copyright © 2019 Amit Naskar. All rights reserved.
//

import Foundation
import UIKit

struct PhotoViewModel {
    let photo: Photo?
    
    init(_ photo: Photo) {
        self.photo = photo
    }
}

extension PhotoViewModel {
    var image: UIImage? {
        return self.photo?.image
    }
    
    var title: String? {
        return self.photo?.title
    }
    
    var desc: String? {
        return self.photo?.desc
    }
}
