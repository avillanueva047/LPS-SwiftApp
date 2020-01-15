//
//  IniciarSesionViewController.swift
//  spaceMines
//
//  Created by Adalid Villanueva on 14/01/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class IniciarSesionViewController: UIViewController {
    
    var usuarios: [NSManagedObject] = []
    var usuario: Usuario!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "Imagen_fondo_LPS.jpg"))
        iniciarSesionBtn.layer.cornerRadius = 7
        cargarUsuarios()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var iniciarSesionBtn: UIButton!
    
    @IBOutlet weak var recordarContraseniaBtn: UIButton!
    
    @IBOutlet weak var nombreUsuarioTxt: UITextField!
    
    @IBOutlet weak var contraseniaUsuarioTxt: UITextField!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func iniciarSesion(_ sender: UIButton) {
        comprobarDatos()
    }
    
    func comprobarDatos(){
        if(nombreUsuarioTxt.hasText && contraseniaUsuarioTxt.hasText){
            for user in usuarios{
                if (user.value(forKey: "correo_electronico") as? String == nombreUsuarioTxt.text){
                    usuario = user as? Usuario
                    if(usuario.contrasenia == contraseniaUsuarioTxt.text){
                        self.performSegue(withIdentifier: "verListaSonares", sender: self)
                    }
                }
            }
            errorUsuarioNoEncontrado()
        }
        else{
            errorDatosNoIntroducidos()
        }
    }
    
    //Obtenemos la lista de Usuarios Guardados
    func cargarUsuarios(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:
            "Usuario")
        do {
            usuarios = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //Error de campos vacíos
    func errorDatosNoIntroducidos(){
        let alert = UIAlertController(title: "Error", message: "Faltan Campos por rellenar, por favor, revíselos antes de continuar", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorUsuarioNoEncontrado(){
        let alert = UIAlertController(title: "Error", message: "No se encuentra el Usuario Registrado", preferredStyle: UIAlertController.Style.alert)
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
