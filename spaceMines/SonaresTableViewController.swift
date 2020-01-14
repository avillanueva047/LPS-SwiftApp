//
//  SonaresTableViewController.swift
//  spaceMines
//
//  Created by Aula11 on 8/1/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class SonaresTableViewController: UITableViewController {

    var usuario: NSManagedObject!
    var sonar: NSManagedObject!
    var sonares =  [NSManagedObject]()
    private let appdelegate = UIApplication.shared.delegate as! AppDelegate
    private let mngcontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
        cargarDatos()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView = UIImageView(image: UIImage(named: "Imagen_fondo_LPS.jpg"))
        
        cargarDatos()
    }
    
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Eliminar"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sonares.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sonar", for: indexPath) as! SonarCell
        
        cell.nombre.text = sonares[indexPath.row].value(forKey: "nombre") as? String
        cell.descripcion.text = sonares[indexPath.row].value(forKey: "descripcion") as? String
        
        if let imagenCD = sonares[indexPath.row].value(forKey: "imagen") as? Data {
            let imagenSonar = UIImage(data: imagenCD)
            cell.imagen.image = imagenSonar
        }
        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let contexto = mngcontext
        contexto.delete(self.sonares[indexPath.row] as NSManagedObject)
        
        self.sonares.remove(at: indexPath.row)
        
        do{
            try contexto.save()
        }catch{

        }
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "exploracionesSonar" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let segueDest = segue.destination as! ExplorarcionTableViewController
                segueDest.sonar = self.sonares[indexPath.row]
            }
        }
    }
    
    @IBAction func ActualizarTabla (sender: UIStoryboardSegue){
        self.cargarDatos()
    }
    
    func cargarDatos(){
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let mngcontext = appdelegate.persistentContainer.viewContext
        
        let fetchRq = NSFetchRequest<NSManagedObject>(entityName: "Sonar")
      //fetchRq.predicate = NSPredicate(format: "pertenece_a == %@", (usuario))
        
        do{
            sonares = try mngcontext.fetch(fetchRq)
        } catch let error as NSError {
            print("Error en la carga de sonares .\(error)")
        }
        
        tableView.reloadData()
    }
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
    let transition = MenuEnTransicion()
    
    
    @IBAction func menuLateral(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.didTapMenuType = { menuType in
            self.transitionToNew(menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate =  self
        present(menuViewController, animated: true)
    }
    
    func transitionToNew(_ menuType: MenuType) {
        //let title = String(describing: menuType).capitalized
        //self.title = title
        //Lista Sonar
        /*if menuType.rawValue == 1{
         let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "NuevoSonarController") as! NuevoSonarController
         
         self.present(registerViewController, animated: true)
         }*/
        //Editar Perfil
        if menuType.rawValue == 2{
            let editarPerfilViewController = self.storyboard?.instantiateViewController(withIdentifier: "NuevoSonarController") as! NuevoSonarController
            self.navigationController?.pushViewController(editarPerfilViewController, animated: true)
        }
        //Contacto
        if menuType.rawValue == 3{
            let editarPerfilViewController = self.storyboard?.instantiateViewController(withIdentifier: "NuevoSonarController") as! NuevoSonarController
            self.navigationController?.pushViewController(editarPerfilViewController, animated: true)
        }
        //Cerrar sesión
        if menuType.rawValue == 4{
            let editarPerfilViewController = self.storyboard?.instantiateViewController(withIdentifier: "NuevoSonarController") as! NuevoSonarController
            self.navigationController?.pushViewController(editarPerfilViewController, animated: true)
        }
    }
}
extension SonaresTableViewController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresentig = true
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresentig = false
        return transition
    }
}
