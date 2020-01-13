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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
