//
//  UUTableViewCell.swift
//  UUDemo
//
//  Created by lhn on 16/11/1.
//  Copyright © 2016年 UUU. All rights reserved.
//

import UIKit

class UUTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLab: UILabel!

    @IBOutlet weak var updateTimeLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentLab.textColor = UIColor.white
        contentLab.font = UIFont.init(name: "PingFangTC-Regular", size: 25)
        contentLab.textAlignment = .left
        
        updateTimeLab.textColor = UIColor.yellow
        updateTimeLab.textAlignment = .right
    }
    func setData(uu:UUModel!) -> Void {
        contentLab.text = uu.content
        updateTimeLab.text = "更新时间：" + uu.updateTime
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
