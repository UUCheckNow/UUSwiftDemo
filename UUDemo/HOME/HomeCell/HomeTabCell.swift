//
//  HomeTabCell.swift
//  UUDemo
//
//  Created by lhn on 16/11/2.
//  Copyright © 2016年 UUU. All rights reserved.
//

import UIKit

class HomeTabCell: UITableViewCell {

    @IBOutlet weak var contentLab: UILabel!
    
    @IBOutlet weak var updataLab: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        updataBtn.addTarget(self, action: #selector(HomeTabCell.touchClick), for:.touchUpInside)
    }
//    func touchClick() {
//        print("点击了按钮啊")
//    }

    func setData(uu:UUModel!) -> Void {
        contentLab.text = uu.content
        updataLab.text = "更新时间：" + uu.updateTime
    }
    
    // Class 初始化
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentLab.textColor = UIColor.white
        contentLab.font = UIFont.init(name: "PingFangTC-Regular", size: 25)
        contentLab.textAlignment = .left
        
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    //    添加如下构造函数 (普通初始化)
    //    override  init() { }
    //    如果控制器需要通过xib加载，则需要添加
    //    required init(coder aDecoder: NSCoder) {}
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
