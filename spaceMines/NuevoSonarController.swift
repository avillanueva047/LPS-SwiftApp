//
//  NuevoSonarController.swift
//  spaceMines
//
//  Created by Aula11 on 8/1/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class NuevoSonarController: UIViewController {

    @IBOutlet weak var imagenSonar: UIImageView!
    @IBOutlet weak var descripcion: UILabel!
    @IBOutlet weak var nombreSonar: UITextField!
    @IBOutlet weak var descSonar: UITextField!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancelar(_ sender: Any) {
        if presentedViewController is UINavigationController{
            dismiss(animated: true, completion: nil)
        }else{
            navigationController!.popViewController(animated: true)
        }
    }
    
    @IBAction func seleccionarImagen(_ sender: UITapGestureRecognizer) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let mngcontext = appdelegate.persistentContainer.viewContext
        
        let entidad = NSEntityDescription.entity(forEntityName: "Sonar", in: mngcontext)!
        
        let sonar = NSManagedObject(entity: entidad, insertInto: mngcontext)
        
        sonar.setValue(nombreSonar.text, forKey: "nombre")
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
