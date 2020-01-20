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
        
        at4.becomeFirstResponder()
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "Imagen_fondo_LPS.jpg"))
        
        guardarDatosBtn.layer.cornerRadius = 7
        at4.useUnderline()
        at11.useUnderline()
        at17.useUnderline()
        at21.useUnderline()
        at36.useUnderline()
        at44.useUnderline()
        at36.useUnderline()
        at44.useUnderline()
        at45.useUnderline()
        at49.useUnderline()
        at52.useUnderline()
        
        
        botonGuardar.isEnabled = false
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var cancelar: UINavigationItem!
    
    @IBOutlet weak var guardarDatosBtn: UIButton!
    
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
        
        #if spaceMines
            exploracion.setValue(imagen?.pngData(), forKey: "imagen")
            exploracion.setValue(tipo, forKey: "tipo")
        #else
            exploracion.setValue(decidirTipo(), forKey: "tipo")
            if decidirTipo() == "Mina" {
                exploracion.setValue(UIImage(named: "minaBien")?.pngData(), forKey: "imagen")
            } else {
                exploracion.setValue(UIImage(named: "rocaBien")?.pngData(), forKey: "imagen")
            }
        #endif
        
       //Relacion
        exploracion.setValue(sonar, forKey: "hecha_por")
        
        do {
            try mngcontext.save()
        } catch let error as NSError {
        print("Se ha producido un error en el guardado de exploracion .\(error)")
        }
    }
    @IBAction func cancelar(_ sender: Any) {
        navigationController!.popViewController(animated: true)

    }
    
    @IBAction func validarDatlos(_ sender: Any) {
        
        let alert = UIAlertController(title: "Error en los datos", message: "Los datos que han introducido son erroneos, por favor, compruebelos otra vez", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        if (at4.text?.isEmpty)! || Double(at4.text!)! > 1.0 || Double(at4.text!)! < 0.0 {
            
            self.present(alert, animated: true, completion: nil)
            
        } else if (at11.text?.isEmpty)! || Double(at11.text!)! > 1.0 || Double(at11.text!)! < 0.0 {
            
            self.present(alert, animated: true, completion: nil)
        
        } else if (at17.text?.isEmpty)! || Double(at17.text!)! > 1.0 || Double(at17.text!)! < 0.0 {
        
            self.present(alert, animated: true, completion: nil)
            
        } else if (at21.text?.isEmpty)! || Double(at21.text!)! > 1.0 || Double(at21.text!)! < 0.0 {
            
            self.present(alert, animated: true, completion: nil)
            
        } else if (at36.text?.isEmpty)! || Double(at36.text!)! > 1.0 || Double(at36.text!)! < 0.0 {
            
            self.present(alert, animated: true, completion: nil)
            
        } else if (at44.text?.isEmpty)! || Double(at44.text!)! > 1.0 || Double(at44.text!)! < 0.0 {
            
            self.present(alert, animated: true, completion: nil)
            
        } else if (at45.text?.isEmpty)! || Double(at45.text!)! > 1.0 || Double(at45.text!)! < 0.0 {
            
            self.present(alert, animated: true, completion: nil)
            
        } else if (at49.text?.isEmpty)! || Double(at49.text!)! > 1.0 || Double(at49.text!)! < 0.0 {
          
            self.present(alert, animated: true, completion: nil)
            
        } else if (at52.text?.isEmpty)! || Double(at52.text!)! > 1.0 || Double(at52.text!)! < 0.0 {
            
            self.present(alert, animated: true, completion: nil)
        
        } else {
            
            botonGuardar.isEnabled = true
            
            #if spaceMines
            
            #else
                let alert2 = UIAlertController(title: "Objeto segun IA", message: "Segun nuestro algoritmo, el objeto se trata de una " + decidirTipo(), preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert2.addAction(ok)
                self.present(alert2, animated: true, completion: nil)
            #endif
        }

    }
    
    
    func decidirTipo() -> String{
        
        let tipoObjeto =  -(1.68 + Double(at4.text!)! * (-2.81) +  Double(at11.text!)! * (-3.26) +  Double(at11.text!)!   * (-3.26) + Double(at11.text!)! * (0.72) + Double(at11.text!)! * (-0.8) + Double(at11.text!)! * (1.57) + Double(at11.text!)! * (-1.2) + Double(at11.text!)! * (-1.79) + Double(at11.text!)! * (-8.6) + Double(at52.text!)! * (-21.16))
       
        if tipoObjeto > 1.68 {
            return "Roca"
        } else {
            return "Mina"
        }
    
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
