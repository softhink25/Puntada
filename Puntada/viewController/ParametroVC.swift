//
//  ParametroVC.swift
//  Puntada
//
//  Created by José Ibarra Martínez on 12/11/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit
import WebKit
import KVNProgress
class ParametroVC: UIViewController {

    @IBOutlet weak var lbltitulo: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var swAcepto: UISwitch!
    @IBOutlet weak var stackCheckbox: UIStackView!
    @IBOutlet weak var btnAceptar: UIButton!
    
    var tipo:Int = 0;
    @IBOutlet weak var dismiss: UIButton!
    @IBAction func dismissAction(_ sender: Any) {
        if(tipo == 0){
            self.dismiss(animated: true, completion: nil)
        }else {
            if(swAcepto.isOn){
//                let url:URL = URL(string: Constants.OBTENER_PARAMETRO)! ;
//                    RemoteRequest.jsonByRequestPost(requestUrl: url, parameters: parameters as [String : Any], completeHandler: { [self] (response) in
//                        if(response?["result"]["success"].bool ?? false){
//                            webView.loadHTMLString((response?["result"]["par_valores"].string!)!, baseURL: url)
//                        }
//                        }, errorHandler: nil, loadingMessage: "Guardando..", view: self.view, showDialogs: true)
                Utils.setData(data: true, key: "condicionesAceptadas")
                self.dismiss(animated: true, completion: nil)
                
            }else{
                KVNProgress.showError(withStatus: "Para Continuar debes aceptar los términos y condiciones")
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Utils.shadowButton(boton: btnAceptar)
        var parameters:[String:Any];
        swAcepto.isOn = Utils.getData(key: "condicionesAceptadas") as? Bool ?? false ;
        if(tipo == 0){
            lbltitulo.text = "Aviso de Privacidad"
            stackCheckbox.isHidden=true;
            parameters = ["par_clave":  "NoticePrivacy"]
        }else{
            parameters = ["par_clave":  "TermsConditions"]
            lbltitulo.text = "Términos y Condiciones"
            stackCheckbox.isHidden=false;
        }
        let url:URL = URL(string: Constants.OBTENER_PARAMETRO)! ;
            RemoteRequest.jsonByRequestPost(requestUrl: url, parameters: parameters as [String : Any], completeHandler: { [self] (response) in
                if(response?["result"]["success"].bool ?? false){
                    webView.loadHTMLString((response?["result"]["par_valores"].string!)!, baseURL: url)
                }
                }, errorHandler: nil, loadingMessage: "Cargando..", view: self.view, showDialogs: true)
        // Do any additional setup after loading the view.
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
