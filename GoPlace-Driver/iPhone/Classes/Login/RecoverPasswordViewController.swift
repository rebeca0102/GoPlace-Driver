//
//  RecoverPasswordViewController.swift
//  RecoverPasswordViewController
//
//  Created by Rebeca Ruiz on 3/10/21.
//

import UIKit
import FirebaseAuth

class RecoverPasswordViewController: UIViewController{
 
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var lblTitulo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitulo.text = "Recuperar\ncontraseña"
    }
    @IBAction func clickBtnArrowBackToLogin(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func tapCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func clickBtnRecover(_ sender: Any) {
        self.validarYEnvidarSolicitud()
    }

    //MARK: - Funciones
    
    func validarYEnvidarSolicitud() {
        
        guard let correo = self.txtCorreo.text, correo.count != 0 else {
            self.showAlertBasic(title: "Error", message: "Ingrese un correo electronico.", acceptButton: "Aceptar")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: correo) { (error) in
            if let error = error {
                self.showAlertBasic(title: "Error", message: "Hubo un problema al reestablecer la contrasena", acceptButton: "Ok")
                print(error)
            } else {
                self.showAlertBasic(title: "Listo", message: "Revise su bandeja de entrada", acceptButton: "Ok")
            }
        }
    }
}
