//
//  ExploracionCell.swift
//  spaceMines
//
//  Created by Aula11 on 8/1/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class ExploracionCell: UITableViewCell {

    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imagen.layer.cornerRadius = imagen.bounds.size.width / 2
        imagen.clipsToBounds = true
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
