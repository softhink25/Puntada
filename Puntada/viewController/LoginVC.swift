//
//  LoginVC.swift
//  Puntada
//
//  Created by José Ibarra Martínez on 05/11/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var txtUsuario: UITextField!
    
    @IBOutlet weak var txtContrasena: UITextField!
    @IBAction func btnEntrarAccion(_ sender: UIButton) {
        let r = RemoteRequest();
        let url:URL = URL(string: Constants.LOGIN)! ;
        let parameters = [ "usu_clave": txtUsuario!.text,"usu_contrasena":txtContrasena!.text];
        r.jsonByRequestPost(requestUrl: url, parameters: parameters as [String : Any], completeHandler: { (response) in
//            print(response)
            }, errorHandler: nil, loadingMessage: "Cargando..", view: self.view, showDialogs: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
