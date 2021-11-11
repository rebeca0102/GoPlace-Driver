//
//  SignUpViewController.swift
//  SignUpViewController
//
//  Created by Rebeca Ruiz on 2/10/21.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController{

    @IBOutlet weak var cnsBottomScroll          : NSLayoutConstraint!
    @IBOutlet weak var txtNombre                : UITextField!
    @IBOutlet weak var txtApellido              : UITextField!
    @IBOutlet weak var txtCelular               : UITextField!
    @IBOutlet weak var txtCorreo                : UITextField!
    @IBOutlet weak var txtClave                 : UITextField!
    
    //MARK: - Ciclo de vida
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerKeyabordNotification()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unregisterKeyboardNotification()
    }
    
    //MARK: - Acciones
    
    @IBAction func clickBtnSignUpBackToLogin(_ sender: Any) {
        self.ValidarYRegistrar()
    }
    
    @IBAction func clickBtnBackToLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapTocloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    //MARK: - Funciones
    
    func setup() {
        
        self.txtCorreo.keyboardType      = .emailAddress
        self.txtClave.isSecureTextEntry  = true
    }
    
    func ValidarYRegistrar() {
        
        guard let nombres = self.txtNombre.text, nombres.count != 0 else {
            self.showAlertBasic(title: "Error", message: "Ingrese su nombre", acceptButton: "Aceptar")
            return
        }
        
        guard let apellidos = self.txtApellido.text, apellidos.count != 0 else {
            self.showAlertBasic(title: "Error", message: "Ingrese sus apellidos", acceptButton: "Aceptar")
            return
        }
        
        guard let celular = self.txtCelular.text, celular.count != 0 else {
            self.showAlertBasic(title: "Error", message: "Ingrese su celular", acceptButton: "Aceptar")
            return
        }
        
        guard let correo = self.txtCorreo.text, correo.count != 0, correo.contains("@") else {
            self.showAlertBasic(title: "Error", message: "Ingrese un correo", acceptButton: "Aceptar")
            return
        }
        
        guard let clave   = self.txtClave.text, clave.count != 0 else {
            self.showAlertBasic(title: "Error", message: "Ingrese su contraseña", acceptButton: "Aceptar")
            return
        }
        
        Auth.auth().createUser(withEmail: correo, password: clave) { (success, error) in
            
            if let result = success, error == nil {
                
                self.showAlertToBack(title: "Listo!", message: "Se registraron tus datos correctamente, ahora puedes iniciar sesión.", acceptButton: "Aceptar")
                print(result)
            } else {
                self.showAlertBasic(title: "Error", message: "Ocurrio un error al crear su cuenta", acceptButton: "Aceptar")
            }
        }
    }
}

//MARK: SignUpViewController - Observers
extension SignUpViewController{
    
     func registerKeyabordNotification() {
         
         NotificationCenter.default.addObserver(self,
                                                selector: #selector(self.keyboardWillShow(_:)),
                                                name: UIResponder.keyboardWillShowNotification,
                                                object: nil)
         
         NotificationCenter.default.addObserver(self,
                                                selector: #selector(self.keyboardWillHide(_:)),
                                                name: UIResponder.keyboardWillHideNotification,
                                                object: nil)
     }
     
     func unregisterKeyboardNotification() {
         
         NotificationCenter.default.removeObserver(self)
     }
     
     @objc func keyboardWillShow(_ notification: Notification) {
         
         let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
         let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
         
         UIView.animate(withDuration: animationDuration) {
             self.cnsBottomScroll.constant = keyboardFrame.size.height
             self.view.layoutIfNeeded()
         }
     }
     
     @objc func keyboardWillHide(_ notification: Notification) {
         
         let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
         
         UIView.animate(withDuration: animationDuration) {
             self.cnsBottomScroll.constant = 0
             self.view.layoutIfNeeded()
         }
     }
}
