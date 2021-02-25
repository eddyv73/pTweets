//
//  AddPostViewController.swift
//  pTweet
//
//  Created by Eddy Wister on 24/02/21.
//

import UIKit
import Simple_Networking
import SVProgressHUD
import NotificationBannerSwift


class AddPostViewController: UIViewController {
    
    //marks
    @IBOutlet weak var postTextView: UITextView!
    @IBAction func addPostAction(){
        savePost()
    }
    @IBAction func DismissAction(){
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private func savePost(){
        let request = PostRequest(text: postTextView.text, imageUrl: nil, videoUrl: nil, location: nil)
        SVProgressHUD.show()
        
        //        SN.post(endpoint: Endpoints.post, model: request) { (response: SNResultWithEntity<Post , ErrorResponse>)} in
        SN.post(endpoint: Endpoints.post, model: request) { (response: SNResultWithEntity<Post , ErrorResponse>) in
            
            SVProgressHUD.dismiss()
            
            switch response{
            case .success:
                self.dismiss(animated: true, completion: nil)
                
            case .error(let error):
                NotificationBanner(subtitle: "Usuario Invalido", style: .warning).show()
                return
                
            case .errorResult(let entity):
                NotificationBanner(subtitle: "Error no controlado", style: .warning).show()
                return
                
            }
        }
        
    }
    
    
    
    
}
