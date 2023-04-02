//
//  SettingTableViewCell.swift
//  AlbumList
//
//  Created by Bowie Tso on 2/4/2023.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var optionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setOptions(optionText: String){
        optionLabel.text = optionText
    }
    
}
