//
//  EditarPerfilViewController.swift
//  spaceMines
//
//  Created by Adalid Villanueva on 19/01/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class EditarPerfilViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var usuario: NSManagedObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "Imagen_fondo_LPS.jpg"))
        nombreUsuarioTxt.useUnderline()
        contraseniaUsuario.useUnderline()
        confirmarContraseniaUsuario.useUnderline()
        cargarFotoPerfil.setRounded()
        cargarFotoPerfil.image = UIImage(data: (usuario.value(forKey: "foto_perfil") as! NSData) as Data)
        nombreUsuarioTxt.text = usuario.value(forKey: "nombre_usuario") as? String
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nombreUsuarioTxt: UITextField!
    
    @IBOutlet weak var contraseniaUsuario: UITextField!
    
    @IBOutlet weak var confirmarContraseniaUsuario: UITextField!
    
    @IBOutlet weak var guardarEditarPerfil: UIBarButtonItem!
    
    @IBOutlet weak var cargarFotoPerfil: UIImageView!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func seleccionarImagen(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)}
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        cargarFotoPerfil.image = info[.originalImage] as?UIImage
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
            if(contraseniaUsuario.text == confirmarContraseniaUsuario.text){
                    return true
            }
            else{
                errorConfirmacionContrasenia()
                return false
            }
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
            let imageData = cargarFotoPerfil.image?.jpegData(compressionQuality: 1.0)
            usuario.setValue(imageData, forKey: "foto_perfil")
            if(nombreIntroducido()){
                usuario.setValue(nombreUsuarioTxt.text, forKey: "nombre_usuario")
            }
            if(contraseniasIntroducidas()){
                usuario.setValue(contraseniaUsuario.text, forKey: "contrasenia")
            }
            do{
                try managedContext.save()
            }
            catch let error as NSError{
                print("No se ha podido Guardar el Usuario.\(error), \(error.userInfo)")
            }
            self.performSegue(withIdentifier: "verPerfilEditado", sender: self)
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
