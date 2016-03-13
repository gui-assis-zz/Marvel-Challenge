//
//  BaseService.swift
//  Marvel Challenge
//
//  Created by Guilherme Assis on 12/03/16.
//  Copyright © 2016 Guilherme Assis. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public typealias RequestBlockCompletion = (JSON?, NSError?) -> Void
public let requestLimit = 20

class BaseService: NSObject {
    
    private let apiVersion = "v1"
    private let host       = "http://gateway.marvel.com:80"
    private let publicKey  = "d6d3532b4f029c0fc012eb242f4df075"
    private let privateKey = "94accbdcfa7d71475e95b8bd9494b32326773e06"
    
    func get(path:String, offset: Int?, parameters: [String: AnyObject]? = nil, requestBlockCompletion: RequestBlockCompletion) {
        
        let url = "\(host)/\(apiVersion)/\(path)"
        let timeStamp = self.getTimeStamp()
        let hash = md5(string: "\(timeStamp)\(self.privateKey)\(self.publicKey)")
        var urlParameters: [String: AnyObject] = ["limit": requestLimit, "offset": offset ?? 0, "apikey": self.publicKey, "ts": timeStamp, "hash": hash]
        
        if let _parameters = parameters {
            for (key, value):(String, AnyObject) in _parameters {
               urlParameters[key] = value
            }
        }
        
        Alamofire.request(.GET, url, parameters: urlParameters)
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        requestBlockCompletion(json["data"]["results"], nil)
                    }
                case .Failure(let error):
                    requestBlockCompletion(nil, error)
                }
        }
    }
    
    private func getTimeStamp() -> String {
        return "\(NSDate().timeIntervalSince1970 * 1000)"
    }
    
    private func md5(string string: String) -> String {
        var digest = [UInt8](count: Int(CC_MD5_DIGEST_LENGTH), repeatedValue: 0)
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
            CC_MD5(data.bytes, CC_LONG(data.length), &digest)
        }
        
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        
        return digestHex
    }
}
