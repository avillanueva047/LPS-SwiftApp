//
//  EditarExploracionViewController.swift
//  spaceMines
//
//  Created by Aula11 on 17/12/19.
//  Copyright © 2019 ual. All rights reserved.
//

import UIKit
import CoreData

class EditarExploracionViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate  {

    @IBOutlet weak var inputNombre: UITextField!
    @IBOutlet weak var inputUbicacion: UITextField!
    @IBOutlet weak var botonGuardar: UIBarButtonItem!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var elegirFecha: UIDatePicker!
    @IBOutlet weak var elegirTipo: UIPickerView!
    
    // var sonar: NSManagedObject!
    var exploracion: NSManagedObject!
    var tipo: String = ""
    let tipos = ["Mina", "Roca"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "Editar " + (exploracion.value(forKey: "nombre") as? String)!
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "Imagen_fondo_LPS.jpg"))

        botonGuardar.isEnabled = false
    }
    
    @IBAction func labelCambia(_ sender: UITextField) {
        botonGuardar.isEnabled = !((sender.text?.isEmpty)!)
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
        tipo = tipos[row]
        imagen.image =  UIImage(named: tipos[row].lowercased() + "Bien" )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let mngcontext = appdelegate.persistentContainer.viewContext
        
        exploracion.setValue(inputNombre.text, forKey: "nombre")
        exploracion.setValue(inputUbicacion.text, forKey: "ubicacion")
        
        let dateformater = DateFormatter()
        dateformater.dateFormat = "MM/dd/yyyy"
        exploracion.setValue(  dateformater.string(from: elegirFecha.date), forKey: "fecha")
        
        exploracion.setValue(tipos, forKey: "tipo")
        exploracion.setValue(imagen.image?.pngData(), forKey: "imagen")

        do {
            try mngcontext.save()
        } catch let error as NSError {
            print("Se ha producido un error en el guardado de edicion de exploracion .\(error)")
        }
        
    }
    
    
    @IBAction func cancelar(_ sender: Any) {
        navigationController!.popViewController(animated: true)
        
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
