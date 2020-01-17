//
//  AtributoViewController.swift
//  spaceMines
//
//  Created by Aula11 on 17/1/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit
import CoreData

class AtributoViewController: UIViewController {

    
    @IBOutlet weak var valorAt: UILabel!
    @IBOutlet var carrusel: iCarousel!
    
    var exploracion: NSManagedObject!
    
    var imagenes = [ UIImage(named: "Vista_X"), UIImage(named: "Vista_gamma"), UIImage(named: "Vista_protones"), UIImage(named: "Vista_alpha 2"), UIImage(named: "Vista_uv"), UIImage(named: "Vista_betha"), UIImage(named: "Vista_electron"), UIImage(named: "Vista_Y"), UIImage(named: "Microondas") ]
    
    var valores: [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valores = cargarValores()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Imagen_fondo_LPS.jpg")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        carrusel.type = .rotary
        carrusel.contentMode = .scaleToFill
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func atras(_ sender: Any) {
        navigationController!.popViewController(animated: true)
    }
    
    func cargarValores() -> [String]{
        
        let valores: [String] = [exploracion.value(forKey: "atributo4") as! String, exploracion.value(forKey: "atributo11") as! String,exploracion.value(forKey: "atributo17") as! String, exploracion.value(forKey: "atributo21") as! String,exploracion.value(forKey: "atributo36") as! String, exploracion.value(forKey: "atributo44") as! String, exploracion.value(forKey: "atributo45") as! String, exploracion.value(forKey: "atributo49") as! String, exploracion.value(forKey: "atributo52") as! String]
        return valores
    }
}

extension AtributoViewController: iCarouselDataSource, iCarouselDelegate {
    

    func numberOfItems(in carousel: iCarousel) -> Int {
        return imagenes.count
    }

    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let tempeView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 290))
        
        tempeView.layer.cornerRadius = tempeView.bounds.size.width / 2.0
        tempeView.clipsToBounds = true
        
        let label = UILabel(frame: CGRect(x: 100, y: 235, width: 200, height: 50))
        
        label.textColor = .black
        label.font = UIFont(name: "System", size: 100)
        label.text = "Valor = " + valores[index]

        tempeView.addSubview(label)
        tempeView.image = imagenes[index]
        return tempeView
    }


}
