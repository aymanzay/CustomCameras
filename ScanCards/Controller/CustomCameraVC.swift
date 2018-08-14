//
//  CustomCameraVC.swift
//  ScanCards
//
//  Created by Ayman Zeine on 8/11/18.
//  Copyright © 2018 Ayman Zeine. All rights reserved.
//

import UIKit
import TesseractOCR

class CustomCameraVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, G8TesseractDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Photos", style: .done, target: self, action: #selector(loadPhotoView))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Camera", style: .done, target: self, action: #selector(loadCameraView))
        
    }
    
    @objc func loadPhotoView() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
        
    }
    
    @objc func loadCameraView() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        dismiss(animated: true, completion: nil)
    }

}
