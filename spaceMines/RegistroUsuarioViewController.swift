//
//  RegistroUsuarioViewController.swift
//  spaceMines
//
//  Created by Aula11 on 7/1/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class RegistroUsuarioViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Imagen fondo LPS.jpg")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        // Do any additional setup after loading the view.
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
