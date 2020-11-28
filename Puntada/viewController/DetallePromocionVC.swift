//
//  DetallePromocionVC.swift
//  Puntada
//
//  Created by José Ibarra Martínez on 27/11/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit
import KVNProgress
class DetallePromocionVC: UIViewController {
    @IBOutlet weak var imgPromocion: UIImageView!
    @IBOutlet weak var imgLogoCompania: UIImageView!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var lblVigencia: UILabel!
     
    var promocion:Promocion? = nil;
    @IBOutlet weak var btnAbrirLink: UIButton!
    @IBAction func abrirLinkAction(_ sender: Any) {
        if promocion?.pro_link == nil{
            KVNProgress.showError(withStatus: "la promoción no tiene un link disponible.")
        }
        if let url = URL(string: promocion!.pro_link) {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        CargarPromocion();

        // Do any additional setup after loading the view.
    }
    func  CargarPromocion()  {
        if promocion != nil {
            lblTitulo.text = promocion?.titulo;
            lblDescripcion.text = promocion?.descripcion;
            lblVigencia.text = promocion?.vigencia_descripcion;
//            btnAbrirLink.isHidden = promocion?.pro_link != nil && promocion?.pro_link.count ?? 0 > 0;
//            btnAbrirLink.titleLabel?.text = promocion?.pro_link;
            RemoteRequest.DownLoadImage(urlStr: Constants.OBTENER_PROMOCION_LOGO+"&pro_id=\(promocion!.pro_id)", imagen: imgLogoCompania)
            RemoteRequest.DownLoadImage(urlStr: Constants.OBTENER_PROMOCION_IMAGEN+"&pro_id=\(promocion!.pro_id)", imagen:imgPromocion)
    //
            btnAbrirLink.frame = CGRect(x: 40, y: 240, width: 320, height: 50)
            let attributedString = NSAttributedString(string: NSLocalizedString("Ir a la Página", comment: ""), attributes:[
                NSAttributedString.Key.font : UIFont.init(name: "neutra text", size: 20.0)!,
                NSAttributedString.Key.foregroundColor : UIColor.blue,
                NSAttributedString.Key.underlineStyle:1.0
            ])
            btnAbrirLink.setAttributedTitle(attributedString, for: .normal)
            self.view.addSubview(btnAbrirLink)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
