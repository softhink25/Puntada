//
//  ViewController.swift
//  Puntada
//
//  Created by Luis Ibarra on 10/14/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imgUsuario: UIImageView!
    @IBOutlet weak var imgProgreso: UIImageView!
    @IBOutlet weak var lblImporte: UILabel!
    @IBOutlet weak var lblPuntos: UILabel!
    @IBOutlet weak var viewContenedorUsuario: UIView!
    @IBOutlet weak var lblUsuario: UILabel!
    @IBOutlet weak var vistaMedia: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nombre:String = Utils.getData(key: "usu_nombre") as! String;
        lblUsuario?.text =  nombre
        let imgDataUsuario = Data(base64Encoded: Utils.getData(key: "usu_imagen") as! String)
        
        imgUsuario.layer.borderWidth = 1
        imgUsuario.layer.masksToBounds = false
        imgUsuario.layer.borderColor = UIColor.black.cgColor
        imgUsuario.layer.cornerRadius = imgUsuario.frame.height/2
        imgUsuario.clipsToBounds = true
        if let imgDataUsuario = imgDataUsuario {
            imgUsuario.image = UIImage(data: imgDataUsuario )
        }
        self.viewContenedorUsuario.layer.masksToBounds = false;
            self.viewContenedorUsuario.layer.cornerRadius = 25;
        self.vistaMedia.layer.masksToBounds = false;
            self.vistaMedia.layer.cornerRadius = 25;
            
    }


}

