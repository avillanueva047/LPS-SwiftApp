//
//  RecuperarContraseniaViewController.swift
//  spaceMines
//
//  Created by Adalid Villanueva on 15/01/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class RecuperarContraseniaViewController: UIViewController {
    
    var usuario: Usuario!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "Imagen_fondo_LPS.jpg"))
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nuevaContraseniaTxt: UITextField!
    
    @IBOutlet weak var comprobacionContraseniaTxt: UITextField!
    
    @IBOutlet weak var recuperarContraseniaBtn: UIButton!
    
    @IBAction func recuperarContrasenia(_ sender: UIButton) {
        if(nuevaContraseniaTxt.hasText && comprobacionContraseniaTxt.hasText){
            
        }
        else{
            
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
