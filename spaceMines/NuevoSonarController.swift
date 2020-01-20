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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        nombreSonar.becomeFirstResponder()
        nombreSonar.delegate = self
        descSonar.delegate =  self
        self.imagenSonar.layer.cornerRadius = imagenSonar.bounds.size.width / 2.0
        self.imagenSonar.clipsToBounds = true
        nombreSonar.useUnderline()
        descSonar.useUnderline()

        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "Imagen_fondo_LPS.jpg"))
        
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

