//
//  NewPasswordViewController.swift
//  NewPasswordViewController
//
//  Created by Rebeca Ruiz on 3/10/21.
//

import UIKit

class NewPasswordViewController: UIViewController{
    
    @IBOutlet weak var txtCorreoNC: UITextField!
    
    @IBAction func clickBtnArrowBackToRecover(_ sender: Any) {
        self.navigationController?.popViewController( animated: true)
    }
    @IBAction func tapCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func swipeToOpenKeyboard(_ sender: Any) {
        self.txtCorreoNC.becomeFirstResponder()
    }
    
    @IBAction func swipeTocloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func clickBtnBackToLogin(_ sender: Any) {
        self.showAlertNewPassword(title: "Listo!", message: "Ya se actualizó la contraseña, vuelve a iniciar sesión.", acceptButton: "Ok!")
    }
}
