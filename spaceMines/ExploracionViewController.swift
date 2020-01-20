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
    
    @IBOutlet weak var verAtributosBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verAtributosBtn.layer.cornerRadius = 7
        inputNombre.becomeFirstResponder()
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "Imagen_fondo_LPS.jpg"))
        
        self.title = "Exploracion " + (exploracion.value(forKey: "nombre") as? String)!
        
        cargarDatos()
        
        inputNombre.isUserInteractionEnabled = false
        inputObjeto.isUserInteractionEnabled = false
        inputFecha.isUserInteractionEnabled = false
        inputUbicacion.isUserInteractionEnabled = false
        
        inputObjeto.useUnderline()
        inputNombre.useUnderline()
        inputFecha.useUnderline()
        inputUbicacion.useUnderline()
    }

    @IBAction func cancelar(_ sender: Any) {
        
        navigationController!.popViewController(animated: true)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "verAtributos" {
            
            let segueDest = segue.destination as! AtributoViewController
            segueDest.exploracion = self.exploracion
            //segueDest.valorAtributos = self.valoreAtributos
            
        } else if segue.identifier == "editarExploracion" {
            
            let segueDest = segue.destination as! EditarExploracionViewController
            segueDest.exploracion = self.exploracion
            
        }
    }
    
    func cargarDatos() {
        
        self.inputFecha.text = exploracion.value(forKey: "fecha") as? String
        self.inputUbicacion.text = exploracion.value(forKey: "ubicacion") as? String
        self.inputNombre.text = exploracion.value(forKey: "nombre") as? String
        
        if let imagenCD = exploracion.value(forKey: "imagen") as? Data {
            let imageneExpl = UIImage(data: imagenCD)
            imagenExploracion.image = imageneExpl
            
            self.imagenExploracion.layer.cornerRadius = imagenExploracion.bounds.size.width / 2.0
            self.imagenExploracion.clipsToBounds = true
        }
        
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
