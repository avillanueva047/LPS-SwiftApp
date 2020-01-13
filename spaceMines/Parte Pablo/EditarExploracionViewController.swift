//
//  EditarExploracionViewController.swift
//  spaceMines
//
//  Created by Aula11 on 17/12/19.
//  Copyright © 2019 ual. All rights reserved.
//

import UIKit
import CoreData

class EditarExploracionViewController: UIViewController {

    @IBOutlet weak var inputNombre: UITextField!
    @IBOutlet weak var inputUbicacion: UITextField!
    @IBOutlet weak var inputFecha: UITextField!
    @IBOutlet weak var botonGuardar: UIBarButtonItem!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var labelTipo: UILabel!
    
    var sonar: NSManagedObject!
    var exploracion: NSManagedObject!
    
    let tipos = ["Mina", "Robot"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Imagen fondo LPS.jpg")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        // Do any additional setup after loading the view.
        botonGuardar.isEnabled = false
    }
    
    @IBAction func labelCambia(_ sender: UITextField) {
        botonGuardar.isEnabled = !((sender.text?.isEmpty)! && (inputUbicacion.text?.isEmpty)! && (inputFecha.text?.isEmpty)!)
    }
    
    @IBAction func cambiaImagen(_ sender: Any) {
        if labelTipo.text == "Mina" {
            imagen.image = UIImage(named: "minaBien")
        } else {
            imagen.image = UIImage(named: "rocaBien")
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tipos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tipos[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        labelTipo.text = tipos[row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let mngcontext = appdelegate.persistentContainer.viewContext
        let entidad = NSEntityDescription.entity(forEntityName: "Exploracion", in: mngcontext)!
        exploracion = NSManagedObject(entity: entidad, insertInto: mngcontext)
        
        exploracion.setValue(inputNombre.text, forKey: "nombre")
        exploracion.setValue(inputUbicacion.text, forKey: "fecha")
        exploracion.setValue(inputFecha.text, forKey: "ubicacion")
        exploracion.setValue(labelTipo.text, forKey: "tipo")
        exploracion.setValue(imagen.image?.pngData(), forKey: "imagen")

        
        do{
            
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
