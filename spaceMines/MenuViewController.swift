//
//  MenuViewController.swift
//  spaceMines
//
//  Created by Aula11 on 14/1/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case img
    case sonar
    case perfil
    case contacto
    case cerrar
}

class MenuViewController: UITableViewController {
    
    var didTapMenuType: ((MenuType) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in
            print("Dismissing: \(menuType)")
            self?.didTapMenuType?(menuType)
        }
    }
    
}

