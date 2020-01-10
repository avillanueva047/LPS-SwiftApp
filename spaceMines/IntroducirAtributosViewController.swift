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

    @IBOutlet weak var at4: UITextField!
    @IBOutlet weak var at11: UITextField!
    @IBOutlet weak var at17: UITextField!
    @IBOutlet weak var at21: UITextField!
    @IBOutlet weak var at36: UITextField!
    @IBOutlet weak var at44: UITextField!
    @IBOutlet weak var at45: UITextField!
    @IBOutlet weak var at49: UITextField!
    @IBOutlet weak var at52: UITextField!
    
    var sonar: NSManagedObject!
    var nombre: String!
    var ubicacion: String!
    var tipo: String!
    var fecha: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.at4.keyboardType = UIKeyboardType.decimalPad
        self.at11.keyboardType = UIKeyboardType.decimalPad
        self.at17.keyboardType = UIKeyboardType.decimalPad
        self.at21.keyboardType = UIKeyboardType.decimalPad
        self.at36.keyboardType = UIKeyboardType.decimalPad
        self.at44.keyboardType = UIKeyboardType.decimalPad
        self.at45.keyboardType = UIKeyboardType.decimalPad
        self.at49.keyboardType = UIKeyboardType.decimalPad
        self.at52.keyboardType = UIKeyboardType.decimalPad

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let mngcontext = appdelegate.persistentContainer.viewContext
        
        let entidad = NSEntityDescription.entity(forEntityName: "Exploracion", in: mngcontext)!
        
        let exploracion = NSManagedObject(entity: entidad, insertInto: mngcontext)
        
        exploracion.setValue(at4.text, forKey: "atributo4")
        exploracion.setValue(at11.text, forKey: "atributo11")
        exploracion.setValue(at17.text, forKey: "atributo17")
        exploracion.setValue(at21.text, forKey: "atributo21")
        exploracion.setValue(at36.text, forKey: "atributo36")
        exploracion.setValue(at44.text, forKey: "atributo44")
        exploracion.setValue(at45.text, forKey: "atributo45")
        exploracion.setValue(at49.text, forKey: "atributo49")
        exploracion.setValue(at52.text, forKey: "atributo52")
        exploracion.setValue(fecha, forKey: "fecha")
        exploracion.setValue(fecha, forKey: "fecha")
        exploracion.setValue(nombre, forKey: "nombre")
        exploracion.setValue(ubicacion, forKey: "ubicacion")
        exploracion.setValue(fecha, forKey: "fecha")
        
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
