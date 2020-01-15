//
//  RecordarContraseniaViewController.swift
//  spaceMines
//
//  Created by Adalid Villanueva on 14/01/2020.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class RecordarContraseniaViewController: UIViewController {
    
    var usuarios: [NSManagedObject]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "Imagen_fondo_LPS.jpg"))
        recordarContraseniaBtn.layer.cornerRadius = 7

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var recordarContraseniaBtn: UIButton!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func recordarContrasenia(_ sender: UIButton) {
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
