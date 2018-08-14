//
//  RecognizeActivityVC.swift
//  ScanCards
//
//  Created by Ayman Zeine on 8/13/18.
//  Copyright © 2018 Ayman Zeine. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import TesseractOCR
import Vision
import CoreML

class RecognizeActivityVC: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate, G8TesseractDelegate {
    
    var textMetadata = [Int: [Int: String]]()
    
    private let context = CIContext()
    
    private func recognizeImage(image: UIImage) {
        if let tesseract = G8Tesseract(language: "eng") {
            tesseract.delegate = self
            tesseract.image = image
            tesseract.recognize()
            
            print(tesseract.recognizedText)
//            if tesseract.recognizedText != nil {
//                let k = Draw(frame: tesseract.rect)
//                k.draw(tesseract.rect)
//            }
//

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        
        captureSession.addInput(input)
        
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "frameQueue"))
        captureSession.addOutput(dataOutput)
        
        
        
        //let request = VNCoreMLRequest(model: <#T##VNCoreMLModel#>, completionHandler: <#T##VNRequestCompletionHandler?##VNRequestCompletionHandler?##(VNRequest, Error?) -> Void#>)
        //VNImageRequestHandler(cgImage: <#T##CGImage#>, options: [:]).perform(<#T##requests: [VNRequest]##[VNRequest]#>)
    }
        
    /*
    func handleResult(_ result: [String: Any]) {
        objc_sync_enter(self)
        guard let wordNumber = result["wordNumber"] as? Int else {
            return
        }
        guard let characterNumber = result["characterNumber"] as? Int else {
            return
        }
        guard let characterClass = result["class"] as? String else {
            return
        }
        if (textMetadata[wordNumber] == nil) {
            let tmp: [Int: String] = [characterNumber: characterClass]
            textMetadata[wordNumber] = tmp
        } else {
            var tmp = textMetadata[wordNumber]!
            tmp[characterNumber] = characterClass
            textMetadata[wordNumber] = tmp
        }
        objc_sync_exit(self)
        DispatchQueue.main.async {
            //hideActivityIndicator()
            self.showDetectedText()
        }
    }
    */
        
    func showDetectedText() {
        var result: String = ""
        if (textMetadata.isEmpty) {
            //detectedText.text = "The image does not contain any text."
            return
        }
        let sortedKeys = textMetadata.keys.sorted()
        for sortedKey in sortedKeys {
            result += word(fromDictionary: textMetadata[sortedKey]!) + " "
        }
        //detectedText.text = result
        print(result)
    }
    
    func word(fromDictionary dictionary: [Int : String]) -> String {
        let sortedKeys = dictionary.keys.sorted()
        var word: String = ""
        for sortedKey in sortedKeys {
            let char: String = dictionary[sortedKey]!
            word += char
        }
        return word
    }
    
    func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //print("camera was able to capture a frame", Date())
        
        guard let uiImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else {
            print("captureOutput didnt work :C")
            return
        }
        recognizeImage(image: uiImage)
        
        /*
         guard let model = try? VNCoreMLModel(for: Alphanum_28x28().model) else { return }
        guard let pixelBuffer: CVPixelBuffer =  CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let request = VNCoreMLRequest(model: model) { (result, error) in
            if error != nil {
                return
            }
            
            //print(result.results)
            
            guard let results = result.results as? [VNClassificationObservation] else { return }
            guard let firstRes = results.first else { return }
            
            print(firstRes.identifier, firstRes.confidence)
            //handleResult(result)
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
         */
    }
}

class Draw: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let h = rect.height
        let w = rect.width
        var color:UIColor = UIColor.yellow
        
        var drect = CGRect(x: (w * 0.25),y: (h * 0.25),width: (w * 0.5),height: (h * 0.5))
        var bpath:UIBezierPath = UIBezierPath(rect: drect)
        
        color.set()
        bpath.stroke()
        
        print("it ran")
        
        NSLog("drawRect has updated the view")
        
    }
    
}
