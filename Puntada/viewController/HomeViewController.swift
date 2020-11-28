//
//  ViewController.swift
//  Puntada
//
//  Created by Luis Ibarra on 10/14/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit
import ProgressBarKit
import KVNProgress
import JMMaskTextField_Swift
class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var selectedIndex = 0;
   @IBOutlet weak var imgUsuario: UIImageView!
    @IBOutlet weak var imgProgreso: UIImageView!
    @IBOutlet weak var lblImporte: UILabel!
    @IBOutlet weak var lblPuntos: UILabel!
    @IBOutlet weak var viewContenedorUsuario: UIView!
    @IBOutlet weak var usuarioCard: UIView! 
    @IBOutlet weak var stackTarjetaQR: UIView!
    @IBOutlet weak var viewDatosTarjeta: UIView!
    @IBOutlet weak var constraintPromocionAlto: NSLayoutConstraint!
    @IBOutlet weak var stackPromociones: UIView!
    @IBOutlet weak var usuarioImgView: UIView!
    
    @IBOutlet weak var viewTarjetaVirtual: UIView!
    @IBOutlet weak var lblUsuario: UILabel!
    @IBOutlet weak var vistaMedia: UIView! 
    @IBOutlet weak var viewProgessContainer: UIView!
    @IBOutlet weak var bronceRedondo: UIView!
    @IBOutlet weak var plataRedondo: UIView!
    @IBOutlet weak var oroRedondo: UIView!
    @IBOutlet weak var diamanteRedondo: UIView!
    @IBOutlet weak var imgQR: UIImageView!
    @IBOutlet weak var topHeight: NSLayoutConstraint!
    @IBOutlet weak var stackHistorial: UIView!
    @IBOutlet weak var promocionesCV: UICollectionView!
    @IBOutlet weak var tarjetaDatosView: UIView!
    
    @IBOutlet weak var lblHistorial: UILabel!
    @IBOutlet weak var lblNumeroTarjeta: UILabel!
    @IBOutlet weak var lblMiembroDesde: UILabel!
    var promociones:[Promocion] = [Promocion]();
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 25, left: 15, bottom: 0, right: 5)
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return promociones.count;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: promocionCell.identificador, for: indexPath) as! promocionCell
        let promocion:Promocion = promociones[indexPath.row];
        cell.lblTitulo.text = promocion.titulo;
        cell.lblVigencia.text = promocion.vigencia_descripcion;
        cell.viewContainer.layer.cornerRadius = 35;
        cell.viewContainer.layer.masksToBounds = true;
//        cell.imgPromocion.image = UIImage.init(imageLiteralResourceName: promociones[indexPath.row])
        RemoteRequest.DownLoadImage(urlStr: Constants.OBTENER_PROMOCION_LOGO+"&pro_id=\(promocion.pro_id)", imagen: cell.imgLogo)
        RemoteRequest.DownLoadImage(urlStr: Constants.OBTENER_PROMOCION_IMAGEN+"&pro_id=\(promocion.pro_id)", imagen: cell.imgPromocion)
//        cell.contentView.contentview = self.promocionesCV.layer.bounds.height
         cell.layer.cornerRadius = 15.0
                cell.layer.borderWidth = 0.0
                cell.layer.shadowColor = UIColor.darkGray.cgColor
                cell.layer.shadowOffset = CGSize(width: 0, height: 0)
                cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.7
                cell.layer.masksToBounds = false
//        cell.view
        cell.constraintPromocionAlto.constant = self.promocionesCV.frame.height*0.4
        cell.viewContainer.frame.size.height = self.promocionesCV.frame.height*0.99;
        return cell
    }
    

    
    let barConfig = PBBarConfiguration(
        roundingCorners: [.allCorners],
        cornerRadii: CGSize(width: 8, height: 8)
    )

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row;
        performSegue(withIdentifier:  "detallesSegue", sender: nil)
    }
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
        viewTarjetaVirtual.isHidden = true;
        stackTarjetaQR.isHidden=true;
        usuarioImgView.isHidden=true;
//        topHeight.constant = 250
//        lblHistorial.isHidden=true;
        stackHistorial.isHidden = true;
        if(activo=="mapa"){
            btnMapa.setImage(UIImage(named: "place icon on"), for: .normal)
            
        }
        if(activo=="perfil"){
            btnPerfil.setImage(UIImage(named: "User icon on"), for: .normal)
            viewContenedorUsuario.isHidden = false
            usuarioImgView.isHidden=false;
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
    override func viewDidAppear(_ animated: Bool) {
        
        
        if(false == Utils.getData(key: "condicionesAceptadas") as? Bool ?? false){
            performSegue(withIdentifier: "terminosSegue", sender:self)
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let pts:Int = Int( Utils.getDataAsString(key: "total_card_points") ?? "0") ?? 0;
        let porcentaje:Double = Double(Double(pts)/Double(300));
        let nombre:String = Utils.getData(key: "usu_nombre") as! String;
        lblUsuario?.text =  nombre
        let imgDataUsuario = Data(base64Encoded: Utils.getData(key: "usu_imagen") as! String)
        let mask = JMStringMask(mask: "0 0000000000 00000")
        let url:URL = URL(string: Constants.CONSULTAR_DATOS_USUARIO)! ;
        let parameters:[String : Any] = [String : Any]();
        RemoteRequest.jsonByRequestSecurePost(requestUrl: url, parameters: parameters  , completeHandler: { (response) in
            if(response?["result"]["success"].bool ?? false){
                Utils.actualizarDatosUsuario(response: response!)
                self.lblPuntos.text = response?["result"]["user_data"]["additional_data"]["total_card_points"].string ?? "0"
//                self.lblMiembroDesde.text = response?["result"]["user_data"]["additional_data"]["dat_fecha_str"].string ?? ""
                let tarjeta = Utils.getDataAsString(key: "dat_tarjeta") ?? ""
               
                let maskedString = mask.mask(string: tarjeta) // returns "30310-360"
                self.lblNumeroTarjeta.text = maskedString
                let img = self.generateQRCode(from: tarjeta)
                
//                self.imgQR.image = img;
                }
            }, errorHandler: {(response) in
                KVNProgress.showError(withStatus: response)
            }, loadingMessage: "Cargando..", view: self.view, showDialogs: true)
        cambiarBoton(activo: "perfil")
        imgUsuario.layer.borderWidth = 1
        imgUsuario.layer.masksToBounds = false
        imgUsuario.layer.borderColor = UIColor.black.cgColor
        imgUsuario.layer.cornerRadius = imgUsuario.frame.height/2
        imgUsuario.clipsToBounds = true
//        bronceRedondo.layer.cornerRadius=bronceRedondo.frame.height/2
//        plataRedondo.layer.cornerRadius=plataRedondo.frame.height/2
//        oroRedondo.layer.cornerRadius=oroRedondo.frame.height/2
//        diamanteRedondo.layer.cornerRadius=diamanteRedondo.frame.height/2
        let parametersPromociones:[String : Any] = [String : Any]();
        let urlProm:URL = URL(string: Constants.OBTENER_PROMOCIONES)! ;
        RemoteRequest.jsonByRequestSecurePost(requestUrl: urlProm, parameters:  parametersPromociones, completeHandler: { (response) in
            print(response!)
            if(response?["result"]["data"].arrayValue.count == 0){
                KVNProgress.showError(withStatus: "No hay Promociones para mostrar",on:self.view)
            }else {
                for prom in response!["result"]["data"].arrayValue {
                    self.promociones.append(Promocion(pro_id: prom["pro_id"].intValue, pro_link: prom["pro_link"].stringValue,  vigencia: prom["pro_vigencia_format"].stringValue, descripcion: prom["pro_descripcion"].stringValue, vigencia_descripcion: prom["pro_vigencia_desc"].stringValue, titulo: prom["pro_titulo"].stringValue))

            }
                DispatchQueue.main.async {
                                self.promocionesCV.reloadData()
                            }
            }
                    }, errorHandler: { (response) in
                        KVNProgress.showError(withStatus: response,on:self.view )
        }, loadingMessage: "Cargando Promociones...", view: self.view, showDialogs: true)
        if let imgDataUsuario = imgDataUsuario {
            imgUsuario.image = UIImage(data: imgDataUsuario )
        }
        self.usuarioCard.layer.masksToBounds = false;
            self.usuarioCard.layer.cornerRadius = 25;
//        self.vistaMedia.layer.masksToBounds = false;
//            self.vistaMedia.layer.cornerRadius = 25;
        self.stackPromociones.layer.masksToBounds = false;
            self.stackPromociones.layer.cornerRadius = 25;
        self.tarjetaDatosView.layer.masksToBounds = false;
            self.tarjetaDatosView.layer.cornerRadius = 25;
        self.viewDatosTarjeta.layer.masksToBounds = false;
        self.viewDatosTarjeta.layer.cornerRadius = 25;
        
        Utils.shadowView(view: self.viewDatosTarjeta)
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
        let tarjeta = Utils.getDataAsString(key: "dat_tarjeta") ?? ""
        lblNumeroTarjeta.text=tarjeta
        let img = generateQRCode(from: tarjeta)

        imgQR.image = img;
        self.promocionesCV.delegate = self;
        self.promocionesCV.dataSource = self;
//        self.constraintPromocionAlto.constant = self.promocionesCV.frame.height*0.3
    }

    override func viewWillAppear(_ animated: Bool) {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detallesSegue"){
            let destView = segue.destination as! DetallePromocionVC
            destView.promocion = promociones[self.selectedIndex]
        }
        if(segue.identifier == "terminosSegue"){
            let destView = segue.destination as! ParametroVC
            destView.tipo = 1
        }
    }
}

