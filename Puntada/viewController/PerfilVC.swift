//
//  PerfilVC.swift
//  Puntada
//
//  Created by José Ibarra Martínez on 18/11/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit
import KVNProgress
class PerfilVC: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    @IBOutlet weak var diaPickerView: UIPickerView!
    @IBOutlet weak var txtTelefono: UITextField!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var datosPersonales: UIStackView!
    @IBOutlet weak var txtNuevaContrasena: UITextField!
    @IBOutlet weak var btnCambiarContrasena: UIButton!
    
    @IBOutlet weak var txtConfirmar: UITextField!
    @IBOutlet weak var txtContrasena: UITextField!
    @IBOutlet weak var contrasenaView: UIStackView!
    @IBOutlet weak var segmentedTabControl: UISegmentedControl!
    @IBOutlet weak var btnAceptar: UIButton!
    let pickerController = UIImagePickerController()
    @IBAction func guardarContrasena(_ sender: Any) {
        if (txtContrasena.text!.isEmpty){
            KVNProgress.showError(withStatus: "La contraseña anterior no puede ser vacia", on: self.view)
            return;
        }
        if (txtConfirmar.text!.isEmpty ){
            KVNProgress.showError(withStatus: "La confirmación de la contraseña no puede ser vacia", on: self.view)
            return;
        }
        if (txtNuevaContrasena.text!.isEmpty ){
            KVNProgress.showError(withStatus: "La contraseña no puede ser vacia", on: self.view)
            return;
        }
        if (txtNuevaContrasena.text != txtConfirmar.text){
            KVNProgress.showError(withStatus: "La contraseña y la confirmación no coinciden ", on: self.view)
            return;
        }
        let url:URL = URL(string: Constants.CAMBIAR_CONTRASENA)! ;
        let parameters:[String : Any] = ["usu_contrasena_actual":txtContrasena.text!.md5(),"usu_contrasena":txtNuevaContrasena.text!.md5()];
        RemoteRequest.jsonByRequestSecurePost(requestUrl: url, parameters: parameters  , completeHandler: { (response) in
            if(response?["result"]["success"].bool ?? false){
                KVNProgress.showSuccess(withStatus: "Perfil Actualizado satisfactoriamente.", on: self.view)
//                Utils.doLogin(response: response!)
            }
            }, errorHandler: nil, loadingMessage: "Actualizando información...", view: self.view, showDialogs: true)
 
    }
    func cambiarSegmento(segmento:Int){
        if(segmento == 0){
            datosPersonales.isHidden = false;
            contrasenaView.isHidden = true
        }else{
            datosPersonales.isHidden = true;
            contrasenaView.isHidden = false
        }
    }
    @IBAction func segmentoCambio(_ sender: Any) {
        cambiarSegmento(segmento: segmentedTabControl.selectedSegmentIndex)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)-> String? {
        if pickerView == mesPickerView{
         return mesData[row]
        }else{
            return diaData[row]
        }
     }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == mesPickerView {
           return  mesData.count;
        }else {
           return diaData.count
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        cambiarSegmento(segmento: 0)
    }
    @IBAction func btnAceptarAccion(_ sender: Any) {
        let url:URL = URL(string: Constants.GUARDAR_USUARIO)! ;
        let parameters:[String : Any] = ["usu_nombre":txtNombre.text!,"usu_correo":txtCorreo.text!,"usu_telefono":txtTelefono.text!,"usu_dia_nacimiento":diaData[diaPickerView.selectedRow(inComponent: 0)],"usu_mes_nacimiento":mesData[mesPickerView.selectedRow(inComponent: 0)]];
        RemoteRequest.jsonByRequestSecurePost(requestUrl: url, parameters: parameters  , completeHandler: { (response) in
            if(response?["result"]["success"].bool ?? false){
                KVNProgress.showSuccess(withStatus: "Perfil Actualizado satisfactoriamente.",on: self.view)
                Utils.actualizarDatosUsuario(response: response!)
            }
            }, errorHandler: nil, loadingMessage: "Actualizando información...", view: self.view, showDialogs: true)
 
    }
    
    var diaData: [String] = [String]()
    var mesData: [String] = [String]()
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var mesPickerView: UIPickerView!
    
    @IBOutlet weak var btnCambiarFoto: UIButton!
    @IBAction func btnCambiarfotoAction(_ sender: Any) {
        
    }
    @IBAction func txtCorreo(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mesPickerView.dataSource = self;
        mesPickerView.delegate = self;
        diaPickerView.dataSource = self;
        diaPickerView.delegate = self;
        for n in 1...31 { 
            diaData.append(String(format: "%02d", n))
        }
        for n in 1...12 {
            mesData.append(String(format: "%02d", n))
        }
        lblNombre.text = Utils.getDataAsString(key: "usu_nombre")
        txtNombre.text = Utils.getDataAsString(key: "usu_nombre")
        txtCorreo.text = Utils.getDataAsString(key: "usu_correo")
        txtTelefono.text = Utils.getDataAsString(key: "usu_telefono")
        imgFoto.clipsToBounds = true
        btnCambiarFoto.clipsToBounds = true
        btnCambiarFoto.layer.cornerRadius = btnCambiarFoto.frame.height/2
        imgFoto.layer.borderWidth = 1
        imgFoto.layer.masksToBounds = false
        imgFoto.layer.borderColor = UIColor.black.cgColor
        imgFoto.layer.cornerRadius = imgFoto.frame.height/2
        imgFoto.clipsToBounds = true
        let imgUsuario = Data(base64Encoded: Utils.getData(key: "usu_imagen") as! String)
        if let imgUsuario = imgUsuario {
            imgFoto.image = UIImage(data: imgUsuario )
        }
        
        diaPickerView.selectRow(diaData.lastIndex(of: Utils.getDataAsString(key: "usu_dia_nacimiento") ?? "0") ?? 0, inComponent: 0, animated: true)
        mesPickerView.selectRow(mesData.lastIndex(of: Utils.getDataAsString(key: "usu_mes_nacimiento") ?? "0") ?? 0, inComponent: 0, animated: true)
        // Do any additional setup after loading the view.
        Utils.shadowButton(boton: btnAceptar);
        Utils.shadowButton(boton: btnCambiarContrasena)
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image"]
         
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
