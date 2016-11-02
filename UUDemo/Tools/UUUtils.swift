//
//  UUUtils.swift
//  UUDemo
//
//  Created by lhn on 16/11/1.
//  Copyright © 2016年 UUU. All rights reserved.
//

import UIKit

class UUUtils: NSObject {
    class func getTextHeight(textStr :String, font :UIFont, labWidth :CGFloat) ->CGFloat {
        let normalStr :NSString = textStr as NSString
        let size = CGSize.init(width: labWidth, height: CGFloat(MAXFLOAT))
        let portDic = NSDictionary(object: font, forKey:NSFontAttributeName as NSCopying)
        let stringSize = normalStr.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: portDic as? [String : AnyObject], context: nil).size
        return stringSize.height + 20

    }
}
