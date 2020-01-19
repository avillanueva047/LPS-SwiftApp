//
//  IniciarSesionViewController.swift
//  spaceMines
//
//  Created by Adalid Villanueva on 14/01/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData


extension UITextField {
    func useUnderline() -> Void {
        let border = CALayer()
        let borderWidth = CGFloat(2.0) // Border Width
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

class IniciarSesionViewController: UIViewController, UITextFieldDelegate{
    
    var usuarios: [NSManagedObject] = []
    var usuario: Usuario!

    override func viewDidLoad() {
        super.viewDidLoad()
        correoUsuario.delegate = self
        contraseniaUsuarioTxt.delegate = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "Imagen_fondo_LPS.jpg"))
        iniciarSesionBtn.layer.cornerRadius = 7
        cargarUsuarios()
        correoUsuario.useUnderline()
        contraseniaUsuarioTxt.useUnderline()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var iniciarSesionBtn: UIButton!
    
    @IBOutlet weak var recordarContraseniaBtn: UIButton!
    
    @IBOutlet weak var correoUsuario: UITextField!
    
    @IBOutlet weak var contraseniaUsuarioTxt: UITextField!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func iniciarSesion(_ sender: UIButton) {
        comprobarDatos()
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide Keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func comprobarDatos(){
        if(correoUsuario.hasText && contraseniaUsuarioTxt.hasText){
            for user in usuarios{
                if (user.value(forKey: "correo_electronico") as? String == correoUsuario.text){
                    usuario = user as? Usuario
                    if(usuario.contrasenia == contraseniaUsuarioTxt.text){
                        self.performSegue(withIdentifier: "verListaSonares", sender: self)
                    }
                    else{
                        errorContrasenia()
                    }
                    break
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
            print("No se ha podido cargar los Usuarios \(error), \(error.userInfo)")
        }
    }
    
    //Error de campos vacíos
    func errorDatosNoIntroducidos(){
        let alert = UIAlertController(title: "Error", message: "Faltan Campos por rellenar, por favor, revíselos antes de continuar", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Error Usuario No Encontrado
    func errorUsuarioNoEncontrado(){
        let alert = UIAlertController(title: "Error", message: "No se encuentra el Usuario Registrado", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Error Contraseña Incorrecta
    func errorContrasenia(){
        let alert = UIAlertController(title: "Error", message: "La contraseña introducida no es correcta", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "recordarContrasenia"){
            let controller = segue.destination as! UINavigationController
            let recordarContraseniaController = controller.topViewController as! RecordarContraseniaViewController
            recordarContraseniaController.usuarios = usuarios
        }
        if (segue.identifier == "verListaSonares"){
            let controller = segue.destination as! UINavigationController
            let listaSonaresController = controller.topViewController as! SonaresTableViewController
            listaSonaresController.usuario = usuario
        }
    }

}
