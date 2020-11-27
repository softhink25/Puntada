//
//  ComoFuncionaVC.swift
//  Puntada
//
//  Created by José Ibarra Martínez on 12/11/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit
class ComoFuncionaVC: UIViewController {
    var actual = 0;
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var lblDescripcion: UILabel!
    @IBAction func btnSiguenteAccion(_ sender: Any) {
        actual = actual+1;
        mostrar()
    }
    
    @IBOutlet weak var lblComoFunciona: UILabel!
    
    let data:[AyudaItem] = [AyudaItem(titulo: "¿Cómo funciona Puntada App?", numero: 1, descripcion: ""),AyudaItem(titulo: "1. Acumula", numero: 2, descripcion: "Obtén puntos en tu tarjeta Puntada por cada compra en nuestros establecimientos participantes."),
                            AyudaItem(titulo: "2. Canjea", numero: 3, descripcion: "¡Utiliza los puntos acumulados para obtener increíbles descuentos y acceder a los mejores rewards en mas de 100 establecimientos!"),
                            AyudaItem(titulo: "3. Maneja", numero: 4, descripcion: "Maneja tus gastos desde la plataforma, factura de forma segura y ubica a nuestros socios de una manera fácil y rápida."), ]
     
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mostrar()
        
    }
    func mostrar(){
        if(actual >= data.count){
            self.dismiss(animated: true, completion: nil)
            return;
        }
        lblComoFunciona.text=data[actual].titulo
        lblDescripcion.text=data[actual].descripcion
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
