//
//  ViewController.swift
//  Puntada
//
//  Created by Luis Ibarra on 10/14/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit
import ProgressBarKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imgUsuario: UIImageView!
    @IBOutlet weak var imgProgreso: UIImageView!
    @IBOutlet weak var lblImporte: UILabel!
    @IBOutlet weak var lblPuntos: UILabel!
    @IBOutlet weak var viewContenedorUsuario: UIView!
    @IBOutlet weak var usuarioCard: UIView!
    @IBOutlet weak var stackPromociones: UIStackView!
    @IBOutlet weak var stackTarjetaQR: UIStackView!
    @IBOutlet weak var viewDatosTarjeta: UIView!
    
    @IBOutlet weak var stackTarjeta: UIStackView!
    @IBOutlet weak var lblUsuario: UILabel!
    @IBOutlet weak var vistaMedia: UIView!
    @IBOutlet weak var viewTarjetaVirtual: UIView!
    @IBOutlet weak var viewProgessContainer: UIView!
    @IBOutlet weak var bronceRedondo: UIView!
    @IBOutlet weak var plataRedondo: UIView!
    @IBOutlet weak var oroRedondo: UIView!
    @IBOutlet weak var diamanteRedondo: UIView!
    @IBOutlet weak var imgQR: UIImageView!
    @IBOutlet weak var topHeight: NSLayoutConstraint!
    @IBOutlet weak var stackHistorial: UIStackView!
    
    @IBOutlet weak var lblHistorial: UILabel!
    @IBOutlet weak var lblNumeroTarjeta: UILabel!
    @IBOutlet weak var lblMiembroDesde: UILabel!
    
    let barConfig = PBBarConfiguration(
        roundingCorners: [.allCorners],
        cornerRadii: CGSize(width: 8, height: 8)
    )

    
    @IBAction func btnPerfilAction(_ sender: UIButton) {
        cambiarBoton(activo: "perfil")
    }
    @IBOutlet weak var btnPerfil: UIButton!
    func cambiarBoton(activo:String){
        btnMapa.setImage(UIImage(named: "place icon off"), for: .normal)
        btnPerfil.setImage(UIImage(named: "user icon off"), for: .normal)
        btnTarjeta.setImage(UIImage(named: "card icon off"), for: .normal)
        btnHistorial.setImage(UIImage(named: "clock icon off"), for: .normal)
        
        viewContenedorUsuario.isHidden=true;
        stackPromociones.isHidden = true;
        viewTarjetaVirtual.isHidden = true;
        stackTarjetaQR.isHidden=true;
        topHeight.constant = 250
        lblHistorial.isHidden=true;
        stackHistorial.isHidden = true;
        if(activo=="mapa"){
            btnMapa.setImage(UIImage(named: "place icon on"), for: .normal)
            
        }
        if(activo=="perfil"){
            btnPerfil.setImage(UIImage(named: "User icon on"), for: .normal)
            viewContenedorUsuario.isHidden = false
            stackPromociones.isHidden = false;
        }
        if(activo=="tarjeta"){
            btnTarjeta.setImage(UIImage(named: "card icon on"), for: .normal)
            viewTarjetaVirtual.isHidden = false;
            stackTarjetaQR.isHidden=false;
        }
        if(activo=="historial"){
            btnHistorial.setImage(UIImage(named: "clock icon on"), for: .normal)
            topHeight.constant = 100
            lblHistorial.isHidden = false
            stackHistorial.isHidden=false;
        }
    }
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }

    
    @IBAction func btnTarjetaAction(_ sender: Any) {
        cambiarBoton(activo: "tarjeta")
    }
    @IBOutlet weak var btnTarjeta: UIButton!
    @IBAction func btnHistorialAction(_ sender: Any) {
        cambiarBoton(activo: "historial")
    }
    
    @IBOutlet weak var btnHistorial: UIButton!
    @IBAction func btnMapaAction(_ sender: Any) {
        cambiarBoton(activo: "mapa")
    }
    @IBOutlet weak var btnMapa: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pts:Double = 200;
        let porcentaje:Double = Double(pts/Double(300));
        let nombre:String = Utils.getData(key: "usu_nombre") as! String;
        lblUsuario?.text =  nombre
        let imgDataUsuario = Data(base64Encoded: Utils.getData(key: "usu_imagen") as! String)
        cambiarBoton(activo: "perfil")
        imgUsuario.layer.borderWidth = 1
        imgUsuario.layer.masksToBounds = false
        imgUsuario.layer.borderColor = UIColor.black.cgColor
        imgUsuario.layer.cornerRadius = imgUsuario.frame.height/2
        imgUsuario.clipsToBounds = true
        bronceRedondo.layer.cornerRadius=bronceRedondo.frame.height/2
        plataRedondo.layer.cornerRadius=plataRedondo.frame.height/2
        oroRedondo.layer.cornerRadius=oroRedondo.frame.height/2
        diamanteRedondo.layer.cornerRadius=diamanteRedondo.frame.height/2
        if let imgDataUsuario = imgDataUsuario {
            imgUsuario.image = UIImage(data: imgDataUsuario )
        }
        self.usuarioCard.layer.masksToBounds = false;
            self.usuarioCard.layer.cornerRadius = 25;
        self.vistaMedia.layer.masksToBounds = false;
            self.vistaMedia.layer.cornerRadius = 25;
        self.viewDatosTarjeta.layer.masksToBounds = false;
        self.viewDatosTarjeta.layer.cornerRadius = 25;
        let trackConfig = PBTrackConfiguration(
            roundingCorners: [.allCorners],
            cornerRadii: CGSize(width: 8, height:5),
            edgeInsets: UIEdgeInsets(top:1, left: 1, bottom: 1, right: 1)
        )
        let bar = ProgressBar(trackColour: [.lightGray], barColour: [.blue], configurations: [.track: [trackConfig]])
        bar.setupProgressBar(in: viewProgessContainer)
        bar.setProgressBarValue(to: CGFloat(porcentaje))
        if(pts>0){
            bronceRedondo.backgroundColor = .blue;
        }
        if(pts>=100){
            plataRedondo.backgroundColor = .blue;
        }
        if(pts>=200){
            oroRedondo.backgroundColor = .blue;
        }
        if(pts>=300){
            diamanteRedondo.backgroundColor = .blue;
        }
        let img = generateQRCode(from: "1234567890")
        imgQR.image = img;
    }


}

