//
//  EditarPerfilViewController.swift
//  spaceMines
//
//  Created by Adalid Villanueva on 19/01/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class EditarPerfilViewController: UIViewController {
    
    var usuario: Usuario!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "Imagen_fondo_LPS.jpg"))
        nombreUsuarioTxt.useUnderline()
        contraseniaUsuario.useUnderline()
        confirmarContraseniaUsuario.useUnderline()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nombreUsuarioTxt: UITextField!
    
    @IBOutlet weak var contraseniaUsuario: UITextField!
    
    @IBOutlet weak var confirmarContraseniaUsuario: UITextField!
    
    @IBOutlet weak var guardarEditarPerfil: UIBarButtonItem!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func passwordMatch() -> Bool{
        if(contraseniaUsuario.text == confirmarContraseniaUsuario.text) {
            return true
        }
        return false
    }
    
    func nombreIntroducido() -> Bool {
        if(nombreUsuarioTxt.hasText){
            return true
        }
        return false
    }
    
    func  contraseniasIntroducidas() -> Bool {
        if(contraseniaUsuario.hasText && confirmarContraseniaUsuario.hasText){
            return true
        }
        return false
    }
    
    func datosIntroducidos() -> Bool{
        return nombreIntroducido() || contraseniasIntroducidas()
    }
    
    @IBAction func guardarEdicionUsuario(_ sender: UIBarButtonItem) {
        if(datosIntroducidos()){
            guard let appDelegate = UIApplication.shared.delegate as?AppDelegate else{
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Usuario", in: managedContext)!
            
            if(nombreIntroducido()){
                
            }
            if(contraseniasIntroducidas()){
                
            }
        }
        else{
            errorDatosNoIntroducidos()
        }
    }
    
    func errorDatosNoIntroducidos(){
        let alert = UIAlertController(title: "Error", message: "No se ha Introducido nuevos Cambios", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorConfirmacionContrasenia(){
        let alert = UIAlertController(title: "Error", message: "La contraseña y su confirmación deben coincidir", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
