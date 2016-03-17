//
//  ImageHelper.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 11/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit
import Nuke
import Kingfisher

public typealias ImageLoadCompletionBlock = (image: UIImage?) -> Void

class ImageHelper: NSObject {
    
    class func loadImageWithUrl(url: NSURL, completion: ImageLoadCompletionBlock) {
        
        let downloader = KingfisherManager.sharedManager.downloader
        let myCache = ImageCache(name: url.absoluteString)
        
        let optionInfo: KingfisherOptionsInfo = [
            .ForceRefresh,
            .TargetCache(myCache)
        ]
        
        downloader.downloadImageWithURL(url, options: optionInfo, progressBlock: nil) { (image, error, imageURL, originalData) -> () in
            completion(image: image)
        }
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
    func loadImageWithUrl(url: String, placeholder: UIImage?) {
        if let _placeholder = placeholder {
            self.image = _placeholder
        }
        
        ImageHelper.loadImageWithUrl(NSURL(string: url)!) { (image) -> Void in
            self.image = image
        }
    }
}
