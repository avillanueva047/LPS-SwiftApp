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
    var sonares =  [NSManagedObject](){
        didSet{
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            if sonares.count == 0 {
                emptyLabel.text = "Sin Sonares por Mostrar"
                emptyLabel.font = UIFont.boldSystemFont(ofSize: 18)
                emptyLabel.tag = 500
                emptyLabel.textAlignment = NSTextAlignment.center
                emptyLabel.textColor = .white
                self.tableView.addSubview(emptyLabel)
            }
            else{
                let viewWithTag = self.view.viewWithTag(500)
                viewWithTag?.removeFromSuperview()
            }
        }
    }
    
    
    private let appdelegate = UIApplication.shared.delegate as! AppDelegate
    private let mngcontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "Imagen_fondo_LPS.jpg")!)
        //buttonMenu.image = usuario.value(forKey: "foto_perfil") as? UIImage 
        cargarDatos()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(verEditarPerfil),
                                               name: NSNotification.Name("VerEditarPerfil"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(verContacto),
                                               name: NSNotification.Name("VerContacto"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(verInicioSesion),
                                               name: NSNotification.Name("VerInicioSesion"),
                                               object: nil)
    }
    
    @objc func verEditarPerfil() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "VerEditarPerfil") as! MiPerfilViewController
        controller.usuario = usuario
        self.navigationController?.pushViewController(controller, animated: true)
        //performSegue(withIdentifier: "ShowSettings", sender: nil)
    }
    
    @objc func verContacto() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "VerContacto") as! ContactoViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func verInicioSesion() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "VerInicioSesion") as! PantallaInicioViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func menuLateral(_ sender: UIBarButtonItem) {
        print("Esta aqui")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    @IBOutlet weak var buttonMenu: UIBarButtonItem!
    
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotacion = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        cell.layer.transform = rotacion
        
        UIView.animate(withDuration: 1.0) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
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
        if editingStyle != .delete {return}
        let alertController = UIAlertController (title: "Aviso", message: "¿Deseas eliminar el sonar \(sonares[indexPath.row].value(forKey: "nombre")!)?", preferredStyle: .alert)
        //Botón eliminar
        let deleteAction = UIAlertAction (title: "Eliminar", style: .destructive, handler: {
            (action) in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            do {
                managedContext.delete(self.sonares[indexPath.row])
                self.sonares.remove(at: indexPath.row)
                try managedContext.save()
                self.tableView.reloadData()
            } catch let error as NSError {
                print("Could not delete. \(error), \(error.userInfo)")
            }
        })
        alertController.addAction(deleteAction)
        //Botón cancelar
        let cancelAction = UIAlertAction (title: "Cancelar", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
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
    
    @IBAction func addSonar(sender: UIStoryboardSegue){
        
        let nombre_sonar: String! = (sender.source as! NuevoSonarController).nombreSonar.text
        let descripcion_sonar: String! = (sender.source as! NuevoSonarController).descSonar.text
        let imagen_sonar: UIImage! = (sender.source as! NuevoSonarController).imagenSonar.image
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let mngcontext = appdelegate.persistentContainer.viewContext
        
        let entidad = NSEntityDescription.entity(forEntityName: "Sonar", in: mngcontext)!
        
        let sonar = NSManagedObject(entity: entidad, insertInto: mngcontext)
        
        sonar.setValue(nombre_sonar, forKey: "nombre")
        sonar.setValue(descripcion_sonar, forKey: "descripcion")
        sonar.setValue(imagen_sonar.pngData(), forKey: "imagen")
        
        do{
            sonares.append(sonar)
            try mngcontext.save()
            self.tableView.reloadData()
        } catch let error as NSError{
            print("Error en el guardado de los atributos de un sonar . \(error)")
        }
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
}
