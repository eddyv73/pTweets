//
//  LoginViewController.swift
//  pTweet
//
//  Created by Eddy Wister on 22/02/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    

    private func setupUI(){
        loginButton.layer.cornerRadius = 25
    }

}
