//
//  ExplorarcionTableViewController.swift
//  spaceMines
//
//  Created by Aula11 on 8/1/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class ExplorarcionTableViewController: UITableViewController {
  
    var sonar: NSManagedObject!
    var exploraciones :[NSManagedObject] = []
    private let appdelegate = UIApplication.shared.delegate as! AppDelegate
    private let mngcontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
        cargarDatos()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarDatos()
        
    }

    // MARK: - Table view data source

    @IBAction func cancelar(_ sender: Any) {
        navigationController!.popViewController(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exploraciones.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exploracion", for: indexPath) as! ExploracionCell

        //nombre
        cell.nombre.text = exploraciones[indexPath.row].value(forKey: "nombre") as? String
        //imagen
        if let imagenCD = exploraciones[indexPath.row].value(forKey: "imagen") as? Data {
            let imageneExpl = UIImage(data: imagenCD)
            cell.imagen.image = imageneExpl
        }
        return cell
     

    }
    
    //Eliminacion de exploraciones
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let contexto = mngcontext
        contexto.delete(self.exploraciones[indexPath.row] as NSManagedObject)
        
        self.exploraciones.remove(at: indexPath.row)
        
        do{
            try contexto.save()
        }catch _{
            
        }
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    @IBAction func ActualizarTablaExploraciones (sender: UIStoryboardSegue){
        
        self.cargarDatos()
    }
    
    
    func cargarDatos(){
      
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let mngcontext = appdelegate.persistentContainer.viewContext
        
        let fetchRq = NSFetchRequest<NSManagedObject>(entityName: "Exploracion")
        fetchRq.predicate = NSPredicate(format: "hecha_por = %@", (sonar))
        
        do{
            exploraciones = try mngcontext.fetch(fetchRq)
        } catch let error as NSError {
            print("Error en la carga de sonares .\(error)")
        }
    
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "exploracion" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let segueDest = segue.destination as! ExploracionViewController
                segueDest.exploracion = self.exploraciones[indexPath.row]
            }
        } else if segue.identifier == "nuevaExploracion" {
           
            let segueDest = segue.destination as! NuevaExploracionViewController
            segueDest.sonar = self.sonar
        }
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
