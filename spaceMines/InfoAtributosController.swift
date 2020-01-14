//
//  InfoAtributosController.swift
//  spaceMines
//
//  Created by Aula11 on 17/12/19.
//  Copyright © 2019 ual. All rights reserved.
//

import UIKit
import CoreData

class InfoAtributosController: UITableViewController {

    var exploracion:  NSManagedObject!
    var nombreAtributos: [String]!
    var valorAtributos: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "Imagen_fondo_LPS.jpg"))
        // Uncomment the following line to preserve selection between presentations
        nombreAtributos = ["Atributo 4", "Atributo 11", "Atributo 17", "Atributo 21", "Atributo 36", "Atributo 44", "Atributo 45", "Atributo 49", "Atributo 52"]
        valorAtributos = cargarValores()
    }
    
    // MARK: - Table view data source

    @IBAction func cacelar(_ sender: Any) {
        navigationController!.popViewController(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nombreAtributos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "atributo", for: indexPath) as! AtributoCell

        cell.nombre.text = nombreAtributos[indexPath.row]
        cell.valor.text = valorAtributos[indexPath.row]

        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        return cell
    }
    
    func cargarValores() -> [String]{
        
        let valores: [String] = [exploracion.value(forKey: "atributo4") as! String, exploracion.value(forKey: "atributo11") as! String,exploracion.value(forKey: "atributo17") as! String, exploracion.value(forKey: "atributo21") as! String,exploracion.value(forKey: "atributo36") as! String, exploracion.value(forKey: "atributo44") as! String, exploracion.value(forKey: "atributo45") as! String, exploracion.value(forKey: "atributo49") as! String, exploracion.value(forKey: "atributo52") as! String]
        return valores
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
