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
    var sonar: NSManagedObject!
    
    @IBOutlet weak var inputNombre: UITextField!
    @IBOutlet weak var inputObjeto: UITextField!
    @IBOutlet weak var inputFecha: UITextField!
    @IBOutlet weak var inputUbicacion: UITextField!
    @IBOutlet weak var imagenExploracion: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Imagen fondo LPS.jpg")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)

        inputNombre.isUserInteractionEnabled = false
        inputObjeto.isUserInteractionEnabled = false
        inputFecha.isUserInteractionEnabled = false
        inputUbicacion.isUserInteractionEnabled = false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "verAtributos" {
            
            let segueDest = segue.destination as! InfoAtributosController
            segueDest.exploracion = self.exploracion
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
