//
//  LoginViewController.swift
//  LoginViewController
//
//  Created by Rebeca Ruiz on 2/10/21.
//

import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var anchorCenteryViewContent: NSLayoutConstraint!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var txtCorreo: UITextField!
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
        //txtCorreo.layer.borderWidth = 1
        //txtCorreo.layer.borderColor = //UIColor.systemGray2.cgColor
    }

    
    @IBAction func swipeToOpenKeyboard(_ sender: Any) {
        self.txtCorreo.becomeFirstResponder()
    }
    @IBAction func swipeToCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    @IBAction func tapToCloseKeyboard(_ sender: Any) {
        self.view.endEditing(true)
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

//MARK: -Keyboard events
extension LoginViewController{
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
