//
//  RegisterViewController.swift
//  pTweet
//
//  Created by Eddy Wister on 22/02/21.
//

import UIKit
import NotificationBannerSwift
import Simple_Networking
import SVProgressHUD


class RegisterViewController: UIViewController {
    //outlets
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var namesTextField: UITextField!
    //IBacktions
    @IBAction func registerButtonAction(){
        performRegister()
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Do any additional setup after loading the view.
    }
    

    private func setupUI(){
        registerButton.layer.cornerRadius = 25
    }
    private func performRegister(){
        guard let email = emailTextField.text, !email.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes Especificar un correo", style: .warning).show()
     
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes Especificar una contraseña", style: .warning).show()
            return
        }
        guard let name = namesTextField.text, !name.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes Especificar un nombre", style: .warning).show()
            return
        }
//        if email != nil , password != nil  {
//            NotificationBanner(title: "Success", subtitle: "Success Login", style: .success).show()
//        }
        let request = RegisterRequest(email: email, password: password, names: name)
        
        SVProgressHUD.show()
        
        SN.post(endpoint: Endpoints.register,
                model: request) {(response: SNResultWithEntity<LoginResponse, ErrorResponse>) in
            SVProgressHUD.dismiss()
            switch response{
            case .success(let user):
                print("login")
                NotificationBanner(subtitle: "Welcome  \(user.user.names)", style: .success).show()
                self.performSegue(withIdentifier: "showHome", sender: nil)
                
            case .error(let error):
                NotificationBanner(subtitle: "Usuario Invalido", style: .warning).show()
                return
                
            case .errorResult(let entity):
                NotificationBanner(subtitle: "Error no controlado", style: .warning).show()
                return
                
            }
        }
        
        
        //performSegue(withIdentifier: "showHome", sender: nil)
    }

}
