//
//  tcUser.swift
//  Puntada
//
//  Created by José Ibarra Martínez on 29/10/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit

class tcUser: UITableViewCell {

    @IBOutlet weak var lblPuntos: UILabel!
    @IBOutlet weak var lblUsuario: UILabel!
    @IBOutlet weak var imgUsuario: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
