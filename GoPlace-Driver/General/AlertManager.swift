//
//  AlertManager.swift
//  AlertManager
//
//  Created by Rebeca Ruiz on 5/10/21.
//

import UIKit

extension UIViewController{
    
    func showAlert(title: String, message: String, acceptButton: String, identifierSegue: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: acceptButton, style: .default) { action in
            self.performSegue(withIdentifier: identifierSegue, sender: nil)
        }
        alert.addAction(acceptAction)
        self.present(alert,animated: true,completion: nil)
    }
    
    func showAlertNewPassword(title: String, message: String, acceptButton: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: acceptButton, style: .default) { action in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(acceptAction)
        self.present(alert,animated: true,completion: nil)
    }
}
