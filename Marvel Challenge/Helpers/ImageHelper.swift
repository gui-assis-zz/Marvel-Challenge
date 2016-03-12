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
    
    class func preHeatImagesForThumbnails(thumbs: [Thumbnail]) {
        var requests: [ImageRequest] = []
        for thumbnail in thumbs {
            requests.append(ImageRequest(URL: thumbnail.getThumbUrl()))
        }
        
        Nuke.startPreheatingImages(requests)
    }
}

extension UIImageView {
    func loadImageWithUrl(url: String, placeholder: UIImage?, reloadCache: Bool) {
        if let _placeholder = placeholder {
            self.image = _placeholder
        }
        
        ImageHelper.loadImageWithUrl(url, reloadCache: reloadCache) { (image) -> Void in
            self.image = image
        }
    }
}
