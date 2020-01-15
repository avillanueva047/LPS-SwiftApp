//
//  RecordarContraseniaViewController.swift
//  spaceMines
//
//  Created by Adalid Villanueva on 14/01/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class RecordarContraseniaViewController: UIViewController {
    
    var usuarios: [NSManagedObject]!
    var usuario: Usuario!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "Imagen_fondo_LPS.jpg"))
        recordarContraseniaBtn.layer.cornerRadius = 7

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var recordarContraseniaBtn: UIButton!
    
    @IBOutlet weak var introducirCorreoTxt: UITextField!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func recordarContrasenia(_ sender: UIButton) {
        return comprobarCorreo()
    }
    
    func comprobarCorreo(){
        if(!introducirCorreoTxt.hasText){
            errorDatosNoIntroducidos()
        }
        if(!isValidEmail(introducirCorreoTxt.text!)){
            errorDeCorreoIntroducido()
        }
        else{
            for user in usuarios{
                if (user.value(forKey: "correo_electronico") as? String == introducirCorreoTxt.text){
                    usuario = user as? Usuario
                    self.performSegue(withIdentifier: "recuperarContraseña", sender: self)
                }
            }
            errorUsuarioNoEncontrado()
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func errorDeCorreoIntroducido(){
        let alert = UIAlertController(title: "Error", message: "El Correo Introducido no posee un formato válido", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorDatosNoIntroducidos(){
        let alert = UIAlertController(title: "Error", message: "Debe introducir un correo electrónico", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorUsuarioNoEncontrado(){
        let alert = UIAlertController(title: "Error", message: "No se encuentra el Usuario Registrado con el correo especificado", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "recuperarContraseña"){
            let recordarContraseniaController = segue.destination as! RecuperarContraseniaViewController
            recordarContraseniaController.usuario = usuario
        }
    }
}
