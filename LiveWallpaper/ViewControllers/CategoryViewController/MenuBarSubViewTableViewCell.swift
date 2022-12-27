//
//  MenuBarSubViewTableViewCell.swift
//  LiveWallpaper
//
//  Created by Aagontuk on 26/12/22.
//

import UIKit

class MenuBarSubViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblMenuName: UILabel!
    @IBOutlet weak var imgMenuImage: UIImageView!
    @IBOutlet weak var imgMenuBackgroundimage: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
