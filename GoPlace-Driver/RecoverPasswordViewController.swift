//
//  RecoverPasswordViewController.swift
//  RecoverPasswordViewController
//
//  Created by Rebeca Ruiz on 3/10/21.
//

import UIKit

class RecoverPasswordViewController: UIViewController{
 
    @IBOutlet weak var txtCorreoRP: UITextField!
    
    @IBAction func clickBtnArrowBackToLogin(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func tapCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func swipeToOpenKeyboard(_ sender: Any) {
        self.txtCorreoRP.becomeFirstResponder()
    }
    
    @IBAction func swipeToCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func clickBtnRecover(_ sender: Any) {
        print("Validando campos de entrada")
        print("Envío de enlace")
        print("Validando")
        print("Redirigiendo al View Nueva Contraseña")
        
        self.showAlert(title: "Listo!", message: "Se envio un link a tu correo para reestablecer la contraseña.", acceptButton: "Ok!",identifierSegue: "NewPasswordViewController")
    }

}
