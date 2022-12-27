//
//  MenuTableViewCell.swift
//  LiveWallpaper
//
//  Created by Twinbit Limited on 26/12/22.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblMenuName: UILabel!
    @IBOutlet weak var imgMenuImage: UIImageView!
    @IBOutlet weak var imgBackGroundImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
