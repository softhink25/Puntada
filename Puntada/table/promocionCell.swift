//
//  promocionCell.swift
//  Puntada
//
//  Created by José Ibarra Martínez on 23/11/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit

class promocionCell: UICollectionViewCell {
    @IBOutlet weak var imgPromocion: UIImageView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblVigencia: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var constraintPromocionAlto: NSLayoutConstraint!
    
    public static let identificador:String = "PromocionCell";
    public static  func nib() -> UINib {
        return UINib(nibName: identificador, bundle: nil)
    }
}
