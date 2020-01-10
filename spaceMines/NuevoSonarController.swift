//
//  NuevoSonarController.swift
//  spaceMines
//
//  Created by Aula11 on 8/1/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class NuevoSonarController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagenSonar: UIImageView!
    @IBOutlet weak var nombreSonar: UITextField!
    @IBOutlet weak var descSonar: UITextField!
    @IBOutlet weak var botonGuardar: UIBarButtonItem!
    
    var usuario: NSManagedObject!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Imagen fondo LPS.jpg")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        botonGuardar.isEnabled = false
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
        }
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

