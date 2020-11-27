//
//  RegistroVC.swift
//  Puntada
//
//  Created by José Ibarra Martínez on 05/11/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit
import KVNProgress
import JMMaskTextField_Swift
class RegistroVC: UIViewController  {
 
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtNip: UITextField!
    @IBOutlet weak var txtNoTarjeta: JMMaskTextField!
    
    @IBOutlet weak var txtContrasena: UITextField!
    @IBOutlet weak var txtConfirmar: UITextField!
    @IBOutlet weak var txtCodigo: UITextField!
    @IBOutlet weak var btnEntrar: UIButton!
    @IBOutlet weak var btnSiguente: UIButton!
//    let mask = JMStringMask(mask: "0 0000000000 00000")
    override func viewDidLoad() {
        super.viewDidLoad()
        Utils.shadowButton(boton: btnEntrar);
        Utils.shadowButton(boton: btnSiguente);
//        txtNoTarjeta = AKMaskField()
//        field.maskExpression = "{d} {dddddddddd} {ddddd}"
//        field.maskTemplate = "4 000000000 00000"
    } 
    @IBAction func terminosAccion(_ sender: Any) {
        performSegue(withIdentifier: "terminosSegue", sender: sender)
    }
    
    @IBAction func privacidadAccion(_ sender: Any) {
        performSegue(withIdentifier: "privacidadSegue", sender: sender)
    }
    
    @IBAction func btnTerminarAccion(_ sender: Any) {
        let url:URL = URL(string: Constants.CONFIRM_CODE)! ;
        let nip = txtNip!.text! as String;
        let tarjeta = txtNoTarjeta!.text! as String;
        let correo = txtCorreo.text! as String;
        let contrasena = txtContrasena.text!
        let codigo = txtCodigo.text!
        if(txtContrasena.text! != txtConfirmar.text! ){
            KVNProgress.showError(withStatus: "La contraseña y la confirmación deben coincidir.")
            return ;
        }
        if(codigo.isEmpty){
            KVNProgress.showError(withStatus: "Favor de Capturar Código")
            return
            
        }
        if(contrasena.isEmpty){
            KVNProgress.showError(withStatus: "Favor de Capturar la Contraseña")
            return
        }
        let parameters = [ "card_number": tarjeta, "card_nip":nip,"user_email":correo,"register_code":codigo,"user_password":contrasena  ] as [String : Any];
        RemoteRequest.jsonByRequestPost(requestUrl: url, parameters: parameters as [String : Any], completeHandler: { (response) in
            if(response?["result"]["success"].bool ?? false){
                KVNProgress.showSuccess(withStatus: "Registro creado, hemos enviado un numero de confirmación al correo registrado" ,on: self.view )
                    
                }
                Utils.doLogin(response:response!)
                self.performSegue(withIdentifier: "home", sender: nil)
            }, errorHandler: nil, loadingMessage: "Cargando..", view: self.view, showDialogs: true)
    }
    @IBAction func segmentoAction(_ sender: UISegmentedControl) {
        cambiarPaso(paso: sender.selectedSegmentIndex)
    }
    func cambiarPaso(paso:Int){
        if(paso==1){
            stackPasoDos.isHidden = false;
            stackPasoUno.isHidden = true;
        }else{
            stackPasoDos.isHidden = true;
            stackPasoUno.isHidden = false;
        }
        segmentado.selectedSegmentIndex = paso;
    }
    @IBOutlet weak var stackPasoDos: UIStackView!
    @IBOutlet weak var stackPasoUno: UIStackView!
    @IBOutlet weak var segmentado: UISegmentedControl!
    @IBAction func btnSiguienteAccion(_ sender: Any) {
        let url:URL = URL(string: Constants.CREATE_CODE)! ;
        let nip = txtNip!.text! as String;
        let tarjeta = txtNoTarjeta!.text! as String;
        let correo = txtCorreo.text! as String;
        if(nip.isEmpty){
            KVNProgress.showError(withStatus: "Favor de Capturar Nip")
            return
        }
        if(tarjeta.isEmpty){
            KVNProgress.showError(withStatus: "Favor de Capturar Tajeta")
            return
        }
        if(correo.isEmpty){
            KVNProgress.showError(withStatus: "Favor de Capturar Correo")
            return
        }
        let parameters = [ "card_number": tarjeta, "card_nip":nip,"user_email":correo  ] as [String : Any];
        RemoteRequest.jsonByRequestPost(requestUrl: url, parameters: parameters as [String : Any], completeHandler: { (response) in
            if(response?["result"]["success"].bool ?? false){
                KVNProgress.showSuccess(withStatus: "Registro creado, hemos enviado un numero de confirmación al correo registrado",on: self.view)
                    self.cambiarPaso(paso: 1)
                    
            }else{
                KVNProgress.showError(withStatus: response?["result"]["message"].string)
            }
            }, errorHandler: nil, loadingMessage: "Cargando..", view: self.view, showDialogs: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "terminosSegue"){
            let destView = segue.destination as! ParametroVC
            destView.tipo = 1
        }
    }
}
