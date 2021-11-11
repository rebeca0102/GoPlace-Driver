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
    
    func showAlertToBack(title: String, message: String, acceptButton: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: acceptButton, style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(acceptAction)
        self.present(alert,animated: true,completion: nil)
    }
    
    func showAlertToBackToRoot(title: String, message: String, acceptButton: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: acceptButton, style: .default) { action in
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(acceptAction)
        self.present(alert,animated: true,completion: nil)
    }
    
    func showAlertBasic(title: String, message: String, acceptButton: String){
            let Alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            Alert.addAction(UIAlertAction(title: acceptButton, style: .default))
            self.present(Alert,animated: true,completion: nil)
    }
}
