//
//  ItemTableViewCell.swift
//  shinchoku
//
//  Created by 片岡崇史 on 2015/08/31.
//  Copyright © 2015年 kataoka. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var textFieldItem: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
