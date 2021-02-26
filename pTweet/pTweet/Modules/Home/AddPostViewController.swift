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
import FirebaseStorage


class AddPostViewController: UIViewController {
    
    //marks
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var previewImageView: UIImageView!
    @IBAction func openCameraAction(_ sender: Any) {
        OpenCamera()
    }
    
    
    @IBAction func addPostAction(){
        savePost()
    }
    @IBAction func DismissAction(){
        dismiss(animated: true, completion: nil)
    }
    //mark propertys
    
    private var imagePicker: UIImagePickerController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private func OpenCamera(){
        imagePicker = UIImagePickerController()
        imagePicker?.sourceType = .camera
        imagePicker?.cameraFlashMode = .off
        imagePicker?.cameraCaptureMode = .photo
        imagePicker?.allowsEditing = true
        imagePicker?.delegate = self
        
        guard let imagePicker = imagePicker else {
            return
        }
        present(imagePicker, animated: true, completion: nil)
        
    }
    private func Uploadphototofirebase(){
        //marks validations
        guard let imagesave = previewImageView.image,
              let imageSavedData: Data = imagesave.jpegData(compressionQuality: 0.1) else {
            return
        }
        
        SVProgressHUD.show()
        //config to save photo on firba
        
        let metadataCOnfig = StorageMetadata()
        metadataCOnfig.contentType = "image/jpg"
        
        //create referece
        let storage = Storage.storage()
        //set name to image
        
        let imageNme = Int.random(in: 100...1000)
        
        //referencecarpet
        
        let folderReference = storage.reference(withPath: "photos-of-ptweets/\(imageNme).jpg")
        
        //uploadphoto
        
        DispatchQueue.global(qos: .background).async {
            folderReference.putData(imageSavedData, metadata: metadataCOnfig){
                (metaData: StorageMetadata? , error: Error?)in
                DispatchQueue.main.async {
                    //detener carga
                    SVProgressHUD.dismiss()
                    if let error = error{
                        NotificationBanner(subtitle: error.localizedDescription , style: .warning).show()
                        return
                    }
                    
                    //obtener url
                    folderReference.downloadURL { (url : URL?, error: Error?) in
                        print(url?.absoluteString ?? "")
                    }
                }
            }
        }
        
        
    }
    private func savePost(){
        Uploadphototofirebase()
        return
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

//mark delegate
extension AddPostViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //asi s eobtiene la imagen
        imagePicker?.dismiss(animated: true, completion: nil)
        if info.keys.contains(.originalImage) {
            previewImageView.isHidden = false
            previewImageView.image = info[.originalImage] as? UIImage
        }
    }
}
