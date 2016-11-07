//
//  UUDataRequest.swift
//  UUDemo
//
//  Created by lhn on 16/11/1.
//  Copyright © 2016年 UUU. All rights reserved.
//

import UIKit
import Alamofire

class UUDataRequest: NSObject {
    
    class func requestData(urlStr aUrlStr: String!, parmas aParmas: Parameters!, completeHandler: ((_ responseObj:DataResponse<Any>) -> Void)?)
    {
        Alamofire.request(aUrlStr, parameters:aParmas).responseJSON {
            (dataResponse: DataResponse) in completeHandler!(dataResponse)
        }
    }

}
