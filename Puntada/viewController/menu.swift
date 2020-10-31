//
//  menu.swift
//  Puntada
//
//  Created by José Ibarra Martínez on 29/10/20.
//  Copyright © 2020 Softhink. All rights reserved.
//

import UIKit

class menu: UITableViewController {

    @IBOutlet var tblMenu: UITableView!
//    var
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblMenu.register(tcUser.self, forCellReuseIdentifier: "tcUser")
        self.tblMenu.register(tcMenu.self, forCellReuseIdentifier: "tcMenu")

        self.tblMenu.dataSource = self;
        self.tblMenu.delegate = self;
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tipo = "tcUser";
        if (indexPath.row > 0){
            tipo = "tcMenu";
        }
        
        if (indexPath.row > 0){
            let cell:tcMenu = tableView.dequeueReusableCell(withIdentifier: tipo, for: indexPath) as! tcMenu
            cell.btnMenuAccion?.setTitle("uno",for: .normal)
            
            return cell;
//            cell.btnMenuAccion.title( "");
        }else{
            let cell:tcUser = tableView.dequeueReusableCell(withIdentifier: tipo, for: indexPath) as! tcUser
            cell.lblPuntos?.text = "14"
            cell.lblUsuario?.text = "Juan Pérez"
            return cell;
        }
        // Configure the cell...

//        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
