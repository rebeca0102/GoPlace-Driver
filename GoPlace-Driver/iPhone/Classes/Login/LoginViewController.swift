//
//  LoginViewController.swift
//  LoginViewController
//
//  Created by Rebeca Ruiz on 2/10/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController{
    
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtClave: UITextField!
    @IBOutlet weak var cnsBottomClave: NSLayoutConstraint!
    
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
    
    @IBAction func btnIniciarSesion(_ sender: Any) {
        self.validarLogin()
    }
    
    @IBAction func tapToCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    //MARK: - Funciones
    
    func setup() {
        
        self.txtCorreo.keyboardType      = .emailAddress
        self.txtClave.isSecureTextEntry  = true
    }
    
    func validarLogin() {
        
        guard let usuario = self.txtCorreo.text, usuario.count != 0, usuario.contains("@") else {
            self.showAlertBasic(title: "Error", message: "Ingrese un correo", acceptButton: "Aceptar")
            return
        }
        
        guard let clave   = self.txtClave.text, clave.count != 0 else {
            self.showAlertBasic(title: "Error", message: "Ingrese su contraseña", acceptButton: "Aceptar")
            return
        }
        
        Auth.auth().signIn(withEmail: usuario, password: clave) { (result,error) in
            
            if let result = result, error == nil {
                self.performSegue(withIdentifier: "HomeViewController", sender: nil)
                print(result)
            } else{
                self.showAlertBasic(title: "Error", message: "La contrasena o el usuario es incorrecto", acceptButton: "Aceptar")
            }
        }
    }
}

//MARK: - LoginViewController - Observers
extension LoginViewController {
   
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
            self.cnsBottomClave.constant = keyboardFrame.size.height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        UIView.animate(withDuration: animationDuration) {
            self.cnsBottomClave.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}
