//
//  RecuperarContraseniaViewController.swift
//  spaceMines
//
//  Created by Adalid Villanueva on 15/01/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class RecuperarContraseniaViewController: UIViewController, UITextFieldDelegate {
    
    var usuario: NSManagedObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        comprobacionContraseniaTxt.delegate = self
        nuevaContraseniaTxt.delegate = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "Imagen_fondo_LPS.jpg"))
        comprobacionContraseniaTxt.useUnderline()
        nuevaContraseniaTxt.useUnderline()
        recuperarContraseniaBtn.layer.cornerRadius = 7
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nuevaContraseniaTxt: UITextField!
    
    @IBOutlet weak var comprobacionContraseniaTxt: UITextField!
    
    @IBOutlet weak var recuperarContraseniaBtn: UIButton!
    
    @IBAction func recuperarContrasenia(_ sender: UIButton) {
        if(nuevaContraseniaTxt.hasText && comprobacionContraseniaTxt.hasText){
            if (nuevaContraseniaTxt.text == comprobacionContraseniaTxt.text){
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
                let managedContext = appDelegate.persistentContainer.viewContext
                usuario.setValue(nuevaContraseniaTxt.text, forKey: "contrasenia")
                do{
                    try managedContext.save()
                    self.performSegue(withIdentifier: "iniciarSesion", sender: self)
                }
                catch let error as NSError{
                    print("No se pudo establece la nueva Contraseña. \(error), \(error.userInfo)")
                }
            }
            else{
                errorConfirmacionContrasenia()
            }
        }
        else{
            errorDatosNoIntroducidos()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide Keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func errorDatosNoIntroducidos(){
        let alert = UIAlertController(title: "Error", message: "Faltan Campos por rellenar, por favor, revíselos antes de continuar", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorConfirmacionContrasenia(){
        let alert = UIAlertController(title: "Error", message: "La contraseña y su confirmación deben coincidir", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
