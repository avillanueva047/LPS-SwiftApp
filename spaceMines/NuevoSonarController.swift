//
//  NuevoSonarController.swift
//  spaceMines
//
//  Created by Aula11 on 8/1/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class NuevoSonarController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagenSonar: UIImageView!
    @IBOutlet weak var nombreSonar: UITextField!
    @IBOutlet weak var descSonar: UITextField!
    @IBOutlet weak var botonGuardar: UIBarButtonItem!
    
    var usuario: NSManagedObject!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        nombreSonar.becomeFirstResponder()
        nombreSonar.delegate = self
        descSonar.delegate =  self
        self.imagenSonar.layer.cornerRadius = imagenSonar.bounds.size.width / 2.0
        self.imagenSonar.clipsToBounds = true
        nombreSonar.useUnderline()
        descSonar.useUnderline()

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Imagen_fondo_LPS.jpg")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        botonGuardar.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide Keyboard
        textField.resignFirstResponder()
        return true
    }
    
    
    
    @IBAction func labelDescCambia(_ sender: UITextField) {
        botonGuardar.isEnabled = !(sender.text?.isEmpty)!
    }
    
    
    @IBAction func cancelar(_ sender: Any) {
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func seleccionarImagen(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imag = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            imagenSonar.image = imag
            self.imagenSonar.layer.cornerRadius = imagenSonar.bounds.size.width / 2.0
            self.imagenSonar.clipsToBounds = true        }
        
        dismiss(animated: true, completion: nil)
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
      
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let mngcontext = appdelegate.persistentContainer.viewContext
        
        let entidad = NSEntityDescription.entity(forEntityName: "Sonar", in: mngcontext)!
        
        let sonar = NSManagedObject(entity: entidad, insertInto: mngcontext)
        
        sonar.setValue(self.nombreSonar.text, forKey: "nombre")
        sonar.setValue(self.descSonar.text, forKey: "descripcion")
        sonar.setValue(self.imagenSonar.image?.pngData(), forKey: "imagen")
        
        do{
            try mngcontext.save()
        } catch let error as NSError{
            print("Error en el guardado de los atributos de un sonar . \(error)")
        }
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

