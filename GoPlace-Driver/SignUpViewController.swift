//
//  SignUpViewController.swift
//  SignUpViewController
//
//  Created by Rebeca Ruiz on 2/10/21.
//

import UIKit

class SignUpViewController: UIViewController{

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var anchorCenteryViewContent: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func clickBtnSignUpBackToLogin(_ sender: Any) {
        self.showAlertToBack(title: "Listo!", message: "Se registraron tus datos correctamente, ahora puedes iniciar sesión.", acceptButton: "Aceptar")
    }
    
    
    @IBAction func clickBtnBackToLogin(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func tapTocloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    @IBAction func swipeToCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func swipeToOpenKeyboard(_ sender: Any) {
        self.txtNombre.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerKeyboardNotification()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unregisterKeyboardNotification()
    }
}

//MARK: -Keyboard Events
extension SignUpViewController{
    
    private func registerKeyboardNotification(){
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func unregisterKeyboardNotification(){
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification){
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        let viewContentFinalPosY = self.viewContent.frame.origin.y + self.viewContent.frame.height
        
        
        
        if keyboardFrame.origin.y < viewContentFinalPosY {
            UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveEaseInOut], animations: {
                let delta = keyboardFrame.origin.y - viewContentFinalPosY
                self.anchorCenteryViewContent.constant = delta
            }, completion: nil)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification){
        
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        UIView.animate(withDuration: animationDuration) {
            self.anchorCenteryViewContent.constant = 0
            self.view.layoutIfNeeded()
        }
        
    }
}
