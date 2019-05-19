//
//  AddPhotoViewController.swift
//  FunFinder
//
//  Created by Ashley Minor on 5/18/19.
//  Copyright © 2019 Ashley Minor. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction func photoLibraryTapped(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    @IBAction func savePhotoTapped(_ sender: UIButton) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let photoToSave = Photos(entity: Photos.entity(), insertInto: context)
            photoToSave.caption = captionText.text
            
            if let userImage = newImageView.image {
                if let userImageData = UIImagePNGRepresentation(userImage) {
                    photoToSave.imageData = userImageData
                }
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            navigationController?.popViewController(animated: true)
        }
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //update photo
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ImageView.image = selectedImage
        }
        //go back to addphotoVC
        imagePicker.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
