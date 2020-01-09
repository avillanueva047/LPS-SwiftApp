//
//  AtributoCell.swift
//  spaceMines
//
//  Created by Aula11 on 7/1/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class AtributoCell: UITableViewCell {

    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var valor: UILabel!
    @IBOutlet weak var barraValor: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func valorCambia(_ sender: Any) {
        valor.text = String(barraValor.value)
    }
}
