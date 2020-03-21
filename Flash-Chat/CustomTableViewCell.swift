//
//  CustomTableViewCell.swift
//  Flash-Chat
//
//  Created by Rishabh on 20/03/20.
//  Copyright © 2020 Rishabh. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
