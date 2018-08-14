//
//  ViewController.swift
//  ScanCards
//
//  Created by Ayman Zeine on 8/10/18.
//  Copyright © 2018 Ayman Zeine. All rights reserved.
//

import UIKit
import TesseractOCR

class ViewController: UIViewController, G8TesseractDelegate {

    @IBOutlet weak var textView: UITextView!
    fileprivate func recognizeImage() {
        if let tesseract = G8Tesseract(language: "eng") {
            tesseract.delegate = self
            tesseract.image = UIImage(named: "demo")?.g8_blackAndWhite()
            tesseract.recognize()
            
            textView.text = tesseract.recognizedText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recognizeImage()
    }
    
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("Recognition progress \(tesseract.progress)%")
    }
    


}

