//
//  MyCustomCell.swift
//  Columba
//
//  Created by Beta on 15/8/23.
//  Copyright (c) 2015年 Beta. All rights reserved.
//

import UIKit

class MyCustomCell: UITableViewCell {

    @IBOutlet weak var myLabel: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
