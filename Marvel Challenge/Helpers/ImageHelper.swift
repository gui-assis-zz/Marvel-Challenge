//
//  ImageHelper.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 11/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit
import Nuke

public typealias ImageLoadCompletionBlock = (image: UIImage?) -> Void

class ImageHelper: NSObject {
    class func loadImageWithUrl(url: String, reloadCache: Bool, completion: ImageLoadCompletionBlock) {
        var request = ImageRequest(URL: NSURL(string: url)!)
        request.memoryCachePolicy = reloadCache ? .ReloadIgnoringCachedImage : .ReturnCachedImageElseLoad
        
        Nuke.taskWith(request) { (response) -> Void in
            completion(image: response.image)
        }.resume()
    }
}

extension UIImageView {
    func loadImageWithUrl(url: String, placeholder: UIImage, reloadCache: Bool) {
        self.image = placeholder
        ImageHelper.loadImageWithUrl(url, reloadCache: reloadCache) { (image) -> Void in
            self.image = image
        }
    }
}
