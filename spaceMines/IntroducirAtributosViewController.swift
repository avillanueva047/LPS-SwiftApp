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
    
    //Estructuras auxiliares para ver lista de atributos
   
    
    override func viewDidLoad() {
        super.viewDidLoad() 
      
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Imagen_fondo_LPS.jpg")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        // Do any additional setup after loading the view.
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
        exploracion.setValue(tipo, forKey: "tipo")
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
