//
//  ExploracionViewController.swift
//  spaceMines
//
//  Created by Aula11 on 8/1/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class ExploracionViewController: UIViewController {
    
    var exploracion: NSManagedObject!
    //var sonar: NSManagedObject!

   // var valoreAtributos: [String]!
    var nombreAtributos: [String]!
    
    @IBOutlet weak var inputNombre: UITextField!
    @IBOutlet weak var inputObjeto: UITextField!
    @IBOutlet weak var inputFecha: UITextField!
    @IBOutlet weak var inputUbicacion: UITextField!
    @IBOutlet weak var imagenExploracion: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        cargarDatos()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Imagen_fondo_LPS.jpg")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        self.title = "Exploracion" + (exploracion.value(forKey: "nombre") as? String)!
        
        cargarDatos()
        
        inputNombre.isUserInteractionEnabled = false
        inputObjeto.isUserInteractionEnabled = false
        inputFecha.isUserInteractionEnabled = false
        inputUbicacion.isUserInteractionEnabled = false
    }
    

    @IBAction func cancelar(_ sender: Any) {
        navigationController!.popViewController(animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "verAtributos" {
            
            let segueDest = segue.destination as! InfoAtributosController
            segueDest.exploracion = self.exploracion
            segueDest.nombreAtributos = self.nombreAtributos
           // segueDest.valorAtributos = self.valoreAtributos
            
        } else if segue.identifier == "editarExploracion" {
            
            let segueDest = segue.destination as! EditarExploracionViewController
            segueDest.exploracion = self.exploracion
            
        }
    }
    
    
    func cargarDatos() {
        
        self.inputFecha.text = exploracion.value(forKey: "fecha") as? String
        self.inputUbicacion.text = exploracion.value(forKey: "ubicacion") as? String
        self.inputNombre.text = exploracion.value(forKey: "nombre") as? String
        self.imagenExploracion.image = exploracion.value(forKey: "imagen") as? UIImage
        self.inputObjeto.text = exploracion.value(forKey: "tipo") as? String
        
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
