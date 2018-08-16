# CustomCameras
Custom camera implementations, some using CoreML and TesseractOCR to perform text recognition.

ScanCards contains a folder /tessdata, which is required in order to perform OCR using the Tesseract library.
The Model folder contains the Alphanum_28x28.mlmodel which is required in order to perform OCR using CoreML.

- ViewController.swift uses Tesseract to extract text from images.
- CustomCameraController.swift is a sample view controller to display an image or the camera via PickerController.
- FrameExtractorVC.swift is a naive custom camera implementation to take still images for later analysis.
