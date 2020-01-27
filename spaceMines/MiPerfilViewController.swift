//
//  MiPerfilViewController.swift
//  spaceMines
//
//  Created by Adalid Villanueva on 19/01/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class MiPerfilViewController: UIViewController {
    
    var usuario : NSManagedObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "Imagen_fondo_LPS.jpg"))
        imagenPerfil.setRounded()
        nombreUsuario.text = usuario.value(forKey: "nombre_usuario") as? String
        correoUsuario.text = usuario.value(forKey: "correo_electronico") as? String
        imagenPerfil.image = UIImage(data: (usuario.value(forKey: "foto_perfil") as! NSData) as Data)
        //imagenPerfil = usuario.foto_perfil
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var imagenPerfil: UIImageView!
    
    @IBOutlet weak var nombreUsuario: UITextField!
    
    @IBOutlet weak var correoUsuario: UITextField!
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "editarPerfil"){
            let controller = segue.destination as! UINavigationController
            let editarPerfilViewController = controller.topViewController as! EditarPerfilViewController
            editarPerfilViewController.usuario = usuario
        }
        if (segue.identifier == "verSonares"){
            let controller = segue.destination as! MenuContainerViewController
            controller.usuario = usuario
        }
    }
}
