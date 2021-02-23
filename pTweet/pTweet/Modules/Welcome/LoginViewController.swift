//
//  LoginViewController.swift
//  pTweet
//
//  Created by Eddy Wister on 22/02/21.
//

import UIKit
import NotificationBannerSwift

class LoginViewController: UIViewController {

    //Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //IBacktions
    @IBAction func loginButtonAction(){
        performLogin()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    //Mark Private actions
    private func setupUI(){
        loginButton.layer.cornerRadius = 25
    }
    private func performLogin(){
        guard let email = emailTextField.text, email.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes Especificar un correo", style: .warning).show()
            return
        }
    }

}
