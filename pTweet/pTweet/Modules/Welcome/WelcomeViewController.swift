//
//  WelcomeViewController.swift
//  pTweet
//
//  Created by Eddy Wister on 22/02/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    //mak outlets
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    


    private func setupUI(){
        loginButton.layer.cornerRadius = 25
    }

}
