//
//  SplashViewController.swift
//  GoPlace-Driver
//
//  Created by Rebeca Ruiz on 10/11/21.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.performSegue(withIdentifier: "LoginViewController", sender: nil)
    }
}

