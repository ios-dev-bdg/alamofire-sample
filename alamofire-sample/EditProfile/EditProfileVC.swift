//
//  EditProfileVC.swift
//  alamofire-sample
//
//  Created by IRFAN TRIHANDOKO on 14/09/20.
//  Copyright © 2020 IRFAN TRIHANDOKO. All rights reserved.
//

import UIKit
import Kingfisher

class EditProfileVC: BaseVC {

    @IBOutlet weak var profileImg: UIImageView!
    
    var imagePicker: UIImagePickerController = UIImagePickerController()
    var selectedImage: UIImage = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Edit Profile"
    }
    
    
    @IBAction func editPhotoAction(_ sender: UIButton) {
        self.openFilePicker()
    }

}

extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openFilePicker() {
        self.imagePicker.delegate = self
        
        let cameraAction: UIAlertAction = UIAlertAction.init(title: "Camera", style: .default) { (action) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true)
        }
        
        let galleryAction: UIAlertAction = UIAlertAction.init(title: "Gallery", style: .default) { (action) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true)
        }
        
        let cancelAction: UIAlertAction = UIAlertAction.init(title: "Cancel", style: .cancel) { (action) in }
        
        self.actionSheet(withTitle: nil, message: nil, actions: [cameraAction, galleryAction,  cancelAction])
    }
    
    func actionSheet(withTitle title: String?, message: String?, actions: [UIAlertAction]) {
        let controller: UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
        for action in actions {
            controller.addAction(action)
        }
        controller.modalPresentationStyle = .fullScreen
        if let popoverController = controller.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            self.selectedImage = image
        } else if let image = info[.originalImage] as? UIImage {
            self.selectedImage = image
        }
        self.imagePicker.dismiss(animated: true, completion: nil)
        self.showSpinner(onView: self.view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.doUploadImage(image: self.selectedImage)
        }
    }
    
    func doUploadImage(image: UIImage?) {
        APIDataSource.doUploadImage(image: image ?? UIImage(), onSuccess: { (id, message) in
            self.removeSpinner()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let url = "\(GITSApps.getImage())\(id)"
                self.profileImg.kf.setImage(with: URL(string: url))
                self.showAlert(title: "Success!", message: message)
            }
        }) { (error) in
            self.removeSpinner()
            self.showAlert(title: "Warning!", message: error ?? "")
        }
    }
    
}
