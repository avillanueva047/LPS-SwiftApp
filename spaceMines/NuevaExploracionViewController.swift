//
//  NuevaExploracionViewController.swift
//  spaceMines
//
//  Created by Aula11 on 9/1/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class NuevaExploracionViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputNombre.useUnderline()
        inputUbicacion.useUnderline()
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "Imagen_fondo_LPS.jpg"))
        inputNombre.becomeFirstResponder()
        /*
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Imagen_fondo_LPS.jpg")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        */
        
        botonSiguiente.isEnabled = false
        
        self.imagen.layer.cornerRadius = imagen.bounds.size.width / 2.0
        self.imagen.clipsToBounds = true
        
        fecha.setValue(UIColor.white, forKeyPath: "textColor")
        
        #if spaceMines
        calcularObjetoBtn.isHidden = true
        #endif
        
        #if spaceMines2
        tipo.isHidden = true
        #endif
        
    }
    
    var sonar: NSManagedObject!
    
    @IBOutlet weak var inputNombre: UITextField!
    @IBOutlet weak var inputUbicacion: UITextField!
    @IBOutlet weak var fecha: UIDatePicker!
    @IBOutlet weak var tipo: UIPickerView!
    @IBOutlet weak var labelTipo: UILabel!
    @IBOutlet weak var calcularObjetoBtn: UIButton!
    
    @IBOutlet weak var botonSiguiente: UIBarButtonItem!
    @IBOutlet weak var imagen: UIImageView!
    
    let tipos = ["Mina", "Roca"]
    
    
    
    @IBAction func cancelar(_ sender: Any) {
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func labelCambia(_ sender: UITextField) {
        botonSiguiente.isEnabled = !(sender.text?.isEmpty)!
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
        imagen.image =  UIImage(named: tipos[row].lowercased() + "Bien" )
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Nombre fuente", size: 25)
            pickerLabel?.textAlignment = .center
        }
        
        pickerLabel?.text = tipos[row]
        pickerLabel?.textColor = UIColor.white
        
        return pickerLabel!
    }
    

    
    /*@IBAction func cambiarImagen(_ sender: Any) {
        if labelTipo.text == "Mina" {
            imagen.image = UIImage(named: "minaBien")
        } else {
            imagen.image = UIImage(named: "rocaBien")
        }
        self.imagen.layer.cornerRadius = imagen.bounds.size.width / 2.0
        self.imagen.clipsToBounds = true
    }*/
    
    /*@IBAction func seleccionarImagen(_ sender: Any) {
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
            imagen.image = imag
        }
        
        dismiss(animated: true, completion: nil)
    }*/
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "introducirAtributos" {
            let segueDest = segue.destination as! IntroducirAtributosViewController
            
            segueDest.nombre = self.inputNombre.text
            segueDest.ubicacion = self.inputUbicacion.text
            segueDest.sonar = self.sonar
            
            let dateformater = DateFormatter()
            dateformater.dateFormat = "MM/dd/yyyy"
            segueDest.fecha = dateformater.string(from: fecha.date)
    
            segueDest.tipo = labelTipo.text
            segueDest.imagen = self.imagen.image
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
