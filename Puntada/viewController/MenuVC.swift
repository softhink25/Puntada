//
//  menu.swift
//  Puntada
//
//  Created by José Ibarra Martínez on 29/10/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit

@objcMembers class menuVC: UITableViewController {

    @IBOutlet var tblMenu: UITableView!
    @IBOutlet weak var imgUsuario: UIImageView!
    @IBOutlet weak var lblUsuario: UILabel!
    @IBOutlet weak var lblPuntos: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    var menuItems: [menuItem] = [menuItem(etiqueta: "", segue: ""),menuItem(etiqueta: "Editar Perfil", segue: "editarPerfilSegue"),menuItem(etiqueta: "Cómo Funciona", segue: "comoFuncionaSegue"),menuItem(etiqueta: "Servicio al Cliente", segue: "servicioSegue"),menuItem(etiqueta: "Aviso de Privacidad", segue: "avisoSegue"),menuItem(etiqueta: "Términos y condiciones", segue: "terminosSegue")]
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tblMenu.register(tcUser.self, forCellReuseIdentifier: "tcUser")
//        self.tblMenu.register(tcMenu.self, forCellReuseIdentifier: "tcMenu")

        self.tblMenu.dataSource = self;
        self.tblMenu.delegate = self;
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        despachar(item: menuItems[indexPath.row])
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count;
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tipo = "tcUser";
        if (indexPath.row > 0){
            tipo = "tcMenu";
        }
        
        if (indexPath.row > 0){
            let cell:tcMenu = tableView.dequeueReusableCell(withIdentifier: tipo, for: indexPath) as! tcMenu
            let item:menuItem = menuItems[indexPath.row]
            cell.lblMenu.text = item.etiqueta
            return cell;
//            cell.btnMenuAccion.title( "");
        }else{
            let cell:tcUser = tableView.dequeueReusableCell(withIdentifier: tipo, for: indexPath) as! tcUser
            cell.lblPuntos?.text = "145"
            let nombre:String = Utils.getData(key: "usu_nombre") as! String;
            cell.lblUsuario?.text =  nombre
            let imgUsuario = Data(base64Encoded: Utils.getData(key: "usu_imagen") as! String)
            
            cell.imgUsuario.layer.borderWidth = 1
            cell.imgUsuario.layer.masksToBounds = false
            cell.imgUsuario.layer.borderColor = UIColor.black.cgColor
            cell.imgUsuario.layer.cornerRadius = cell.imgUsuario.frame.height/2
            cell.imgUsuario.clipsToBounds = true
            if let imgUsuario = imgUsuario {
                cell.imgUsuario.image = UIImage(data: imgUsuario )
            }
            return cell;
        }
        // Configure the cell...

//        return cell
    }
     func despachar(item:menuItem) {
        self.performSegue(withIdentifier: item.segue, sender: self)
    }
    @objc func despachar() {
            
        }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row > 0){
            return 40;
        }else{
            return 280;
        }
        
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "terminosSegue"){
            let destView = segue.destination as! ParametroVC
            destView.tipo = 1
        }
    }

}
