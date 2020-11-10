//
//  LoginVC.swift
//  Puntada
//
//  Created by José Ibarra Martínez on 05/11/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit
import CryptoSwift
import SwiftyJSON 

class LoginVC: UIViewController   {
    
    @IBOutlet weak var txtUsuario: UITextField!
    
    @IBOutlet weak var txtContrasena: UITextField!
    @IBAction func btnEntrarAccion(_ sender: UIButton) {
        let url:URL = URL(string: Constants.LOGIN)! ;
        let pwd = txtContrasena!.text! as String;
        let parameters = [ "usu_clave": txtUsuario!.text!, "usu_contrasena":pwd.md5()  ] as [String : Any];
        RemoteRequest.jsonByRequestPost(requestUrl: url, parameters: parameters as [String : Any], completeHandler: { (response) in
            if(response?["result"]["success"].bool ?? false){
//                Utils.setData(data: response?["result"]["user_data"] as Any, key: "user_data")
                Utils.setData(data: response?["result"]["access_token"].string, key: "access_token")
                self.performSegue(withIdentifier: "home", sender: nil)
                
                }
            }, errorHandler: nil, loadingMessage: "Cargando..", view: self.view, showDialogs: true)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home"{

//                let destView = segue.destination as! HomeViewController
        }
    }

}
