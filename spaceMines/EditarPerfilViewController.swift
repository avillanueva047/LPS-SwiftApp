//
//  EditarPerfilViewController.swift
//  spaceMines
//
//  Created by Adalid Villanueva on 19/01/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class EditarPerfilViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "Imagen_fondo_LPS.jpg"))
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nombreUsuarioTxt: UITextField!
    
    @IBOutlet weak var contraseniaUsuario: UITextField!
    
    @IBOutlet weak var confirmarContraseniaUsuario: UITextField!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
