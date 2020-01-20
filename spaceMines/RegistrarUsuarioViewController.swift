//
//  RegistrarUsuarioViewController.swift
//  spaceMines
//
//  Created by Adalid Villanueva on 14/01/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData


//Hace de la imagen redonda
extension UIImageView {
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
}

class RegistrarUsuarioViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        nombreUsuarioTxt.becomeFirstResponder()
        nombreUsuarioTxt.delegate = self
        correoUsuarioTxt.delegate = self
        contraseniaUsuarioTxt.delegate = self
        repetirContraseniaTxt.delegate = self
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "Imagen_fondo_LPS.jpg"))
        registrarUsuarioBtn.layer.cornerRadius = 7
        cargarFotoPerfil.setRounded()
        nombreUsuarioTxt.useUnderline()
        correoUsuarioTxt.useUnderline()
        contraseniaUsuarioTxt.useUnderline()
        repetirContraseniaTxt.useUnderline()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var registrarUsuarioBtn: UIButton!
    
    @IBAction func registrarUsuarioBtn(_ sender: UIButton) {
        if(datosIntroducidos()){
            if(isValidEmail(correoUsuarioTxt.text!)){
                if(passwordMatch()){
                    //Guardamos el Usuario
                    guard let appDelegate = UIApplication.shared.delegate as?AppDelegate else{
                        return
                    }
                    let managedContext = appDelegate.persistentContainer.viewContext
                    let entity = NSEntityDescription.entity(forEntityName: "Usuario", in: managedContext)!
                    
                    //¿Existe el Usuario?
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
                    fetchRequest.predicate = NSPredicate(format: "correo_electronico = %@", correoUsuarioTxt.text!)
                    do{
                        let fetchResult = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
                        if (fetchResult.count != 0){
                            errorUsuarioExistente()
                        }
                        else{
                            let imageData = cargarFotoPerfil.image?.jpegData(compressionQuality: 1.0)
                            let usuario = NSManagedObject(entity: entity, insertInto: managedContext)
                            usuario.setValue(nombreUsuarioTxt.text, forKey: "nombre_usuario")
                            usuario.setValue(contraseniaUsuarioTxt.text, forKey: "contrasenia")
                            usuario.setValue(correoUsuarioTxt.text, forKey: "correo_electronico")
                            usuario.setValue(imageData, forKey: "foto_perfil")
                            
                            do{
                                try managedContext.save()
                            }
                            catch let error as NSError{
                                print("No se ha podido Guardar el Usuario.\(error), \(error.userInfo)")
                            }
                            self.performSegue(withIdentifier: "iniciarSesionSegue", sender: self)
                        }
                    }
                    catch let error as NSError{
                        print("No se ha podido Realizar la Consulta. \(error), \(error.userInfo)")
                    }
                }
                else{
                    errorConfirmacionContrasenia()
                }
            }
            else{
                errorDeCorreoIntroducido()
            }
            
        }
        else{
            errorDatosNoIntroducidos()
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var nombreUsuarioTxt: UITextField!
    
    @IBOutlet weak var correoUsuarioTxt: UITextField!
    
    @IBOutlet weak var contraseniaUsuarioTxt: UITextField!
    
    @IBOutlet weak var repetirContraseniaTxt: UITextField!
    
    @IBOutlet weak var cargarFotoPerfil: UIImageView!
    
    //Carga de Imagen
    @IBAction func seleccionarImagen(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide Keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)}
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        cargarFotoPerfil.image = info[.originalImage] as?UIImage
        dismiss(animated: true, completion: nil)
    }
    
    //Comprueba si todos los campos esta rellenos
    func datosIntroducidos() -> Bool{
        if(nombreUsuarioTxt.hasText && correoUsuarioTxt.hasText && contraseniaUsuarioTxt.hasText && contraseniaUsuarioTxt.hasText){
            return true
        }
        return false
    }
    
    //Comprobamos si el campo de
    //confirmación es correcto
    func passwordMatch() -> Bool{
        if(contraseniaUsuarioTxt.text == repetirContraseniaTxt.text) {
            return true
        }
        return false
    }
    
    //Valida si el correo introducido
    //tiene un formato correcto
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //Formato de Correo Incorrecto
    func errorDeCorreoIntroducido(){
        let alert = UIAlertController(title: "Error", message: "El Correo Introducido no posee un formato válido", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Error de Confirmacion
    func errorConfirmacionContrasenia(){
        let alert = UIAlertController(title: "Error", message: "La contraseña y su confirmación deben coincidir", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Error de campos vacíos
    func errorDatosNoIntroducidos(){
        let alert = UIAlertController(title: "Error", message: "Faltan Campos por rellenar, por favor, revíselos antes de continuar", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorUsuarioExistente(){
        let alert = UIAlertController(title: "Error", message: "Ya existe un Usuario registrado con dicho correo", preferredStyle: UIAlertController.Style.alert)
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
