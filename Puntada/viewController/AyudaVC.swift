//
//  AyudaVC.swift
//  Puntada
//
//  Created by José Ibarra Martínez on 18/11/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit

class AyudaVC: UIViewController {

    @IBOutlet weak var btnSiguente: UIButton!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBAction func btnSiguenteAction(_ sender: Any) {
    }
    @IBAction func btnCloseAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var closeAction: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Utils.shadowButton(boton: btnSiguente)
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
