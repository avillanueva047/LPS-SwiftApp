//
//  MenuViewController.swift
//  spaceMines
//
//  Created by Aula11 on 14/1/20.
//  Copyright © 2020 ual. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        
        switch indexPath.row {
        case 0:
            NotificationCenter.default.post(name: NSNotification.Name("VerImagen"), object: nil)
        case 1:
            NotificationCenter.default.post(name: NSNotification.Name("VerEditarPerfil"), object: nil)
        case 2:
            NotificationCenter.default.post(name: NSNotification.Name("VerContacto"), object: nil)
        case 3:
            NotificationCenter.default.post(name: NSNotification.Name("VerInicioSesion"), object: nil)
        default: break
        }
    }
}
