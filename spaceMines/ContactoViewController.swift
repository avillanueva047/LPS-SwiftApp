//
//  ContactoViewController.swift
//  spaceMines
//
//  Created by Aula11 on 20/1/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class ContactoViewController: UIViewController {
    
    var usuario : NSManagedObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagenPerfil.setRounded()
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "Imagen_fondo_LPS.jpg"))
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var imagenPerfil: UIImageView!
    
    @IBOutlet weak var nombreEquipoTxt: UITextField!
    
    @IBOutlet weak var telefonoContactoTxt: UITextField!
    
    @IBOutlet weak var direccionContactoTxt: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "verSonares"){
            let controller = segue.destination as! MenuContainerViewController
            controller.usuario = usuario
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
