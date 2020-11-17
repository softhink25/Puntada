//
//  ComoFuncionaVC.swift
//  Puntada
//
//  Created by José Ibarra Martínez on 12/11/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit
import Presentation
class ComoFuncionaVC: UIViewController {
    

    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController1 = UIViewController()
        viewController1.title = "¿Cómo funciona Puntada App?"

        let viewController2 = UIViewController()
        viewController2.title = "1. Acumula"
        let presentationController = PresentationController(pages: [viewController1, viewController2])
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
