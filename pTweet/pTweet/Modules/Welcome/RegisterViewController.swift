//
//  RegisterViewController.swift
//  pTweet
//
//  Created by Eddy Wister on 22/02/21.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Do any additional setup after loading the view.
    }
    

    private func setupUI(){
        registerButton.layer.cornerRadius = 25
    }


}
