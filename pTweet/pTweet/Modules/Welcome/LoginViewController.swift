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
        view.endEditing(true)
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
        guard let email = emailTextField.text, !email.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes Especificar un correo", style: .warning).show()
     
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes Especificar una contraseña", style: .warning).show()
            return
        }
        if email != nil , password != nil  {
            NotificationBanner(title: "Success", subtitle: "Success Login", style: .success).show()
        }
        
        performSegue(withIdentifier: "showHome", sender: nil)
    }

}
