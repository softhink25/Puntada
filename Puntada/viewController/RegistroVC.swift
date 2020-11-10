//
//  RegistroVC.swift
//  Puntada
//
//  Created by José Ibarra Martínez on 05/11/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit 

class RegistroVC: UIViewController {
 
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtNip: UITextField!
    @IBOutlet weak var txtNoTarjeta: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func siguenteAccion(_ sender: Any) {
        cambiarPaso(paso: 1)
    }
    @IBAction func segmentoAction(_ sender: UISegmentedControl) {
        let rr:RemoteRequest = RemoteRequest();
        
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
        cambiarPaso(paso: 0)
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
