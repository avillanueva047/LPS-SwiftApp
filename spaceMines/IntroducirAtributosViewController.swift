//
//  IntroducirAtributosViewController.swift
//  spaceMines
//
//  Created by Aula11 on 10/1/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class IntroducirAtributosViewController: UIViewController {

    //Atributos de cada exploracion
    @IBOutlet weak var at4: UITextField!
    @IBOutlet weak var at11: UITextField!
    @IBOutlet weak var at17: UITextField!
    @IBOutlet weak var at21: UITextField!
    @IBOutlet weak var at36: UITextField!
    @IBOutlet weak var at44: UITextField!
    @IBOutlet weak var at45: UITextField!
    @IBOutlet weak var at49: UITextField!
    @IBOutlet weak var at52: UITextField!
    @IBOutlet weak var botonGuardar: UIBarButtonItem!
    
    //Valores que se nos dan en el segue de la vista anterior
    var imagen: UIImage!
    var sonar: NSManagedObject!
    var nombre: String!
    var ubicacion: String!
    var tipo: String!
    var fecha: String!
    
    //Estructuras auxiliares para obsrevar ver lista de atributos
    var nombreAtributos: [String]!
    var valorAtributos: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        botonInactivo()
        
        // Do any additional setup after loading the view.
    }
    
    func botonInactivo(){
        if((at4.text?.isEmpty)! && (at11.text?.isEmpty)! && (at17.text?.isEmpty)! && (at21.text?.isEmpty)! && (at36.text?.isEmpty)! && (at44.text?.isEmpty)! && (at45.text?.isEmpty)! && (at49.text?.isEmpty)! && (at52.text?.isEmpty)!){
            botonGuardar.isEnabled = false
        }else{
            botonGuardar.isEnabled = true
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        nombreAtributos = ["Atributo 4", "Atributo 11", "Atributo 17", "Atributo 21", "Atributo 36", "Atributo 44", "Atributo 45", "Atributo 49", "Atributo 52"]
        valorAtributos = [at4.text!, at11.text!, at17.text!, at21.text!, at36.text!, at44.text!, at45.text!, at49.text!, ]
        
        let segueDest = segue.destination as! ExplorarcionTableViewController
        segueDest.nombreAtributos = self.nombreAtributos
        segueDest.valorAtributos = self.valorAtributos
        
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let mngcontext = appdelegate.persistentContainer.viewContext
        
        let entidad = NSEntityDescription.entity(forEntityName: "Exploracion", in: mngcontext)!
        
        let exploracion = NSManagedObject(entity: entidad, insertInto: mngcontext)
        
       //Atributos
        exploracion.setValue(at4.text, forKey: "atributo4")
        exploracion.setValue(at11.text, forKey: "atributo11")
        exploracion.setValue(at17.text, forKey: "atributo17")
        exploracion.setValue(at21.text, forKey: "atributo21")
        exploracion.setValue(at36.text, forKey: "atributo36")
        exploracion.setValue(at44.text, forKey: "atributo44")
        exploracion.setValue(at45.text, forKey: "atributo45")
        exploracion.setValue(at49.text, forKey: "atributo49")
        exploracion.setValue(at52.text, forKey: "atributo52")
       //Caracteristicas
        exploracion.setValue(fecha, forKey: "fecha")
        exploracion.setValue(nombre, forKey: "nombre")
        exploracion.setValue(ubicacion, forKey: "ubicacion")
        exploracion.setValue(imagen?.pngData(), forKey: "imagen")
       //Relacion
        exploracion.setValue(sonar, forKey: "hecha_por")
        
        do {
            try mngcontext.save()
        } catch let error as NSError {
        print("Se ha producido un error en el guardado de exploracion .\(error)")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     fecha
     nombre
     tipo
     ubicacion
     imagen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
