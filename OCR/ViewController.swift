//
//  ViewController.swift
//  OCR
//
//  Created by Александр Игнатьев on 17.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    let maxDimension = 640
    let TesseractLanguages = "eng+rus"
    
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var cameraButton: UIBarButtonItem!
    @IBOutlet var shareButton: UIBarButtonItem!
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Actions

    @IBAction func cameraAction(sender: UIBarButtonItem) {
        let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Photo", message: nil, preferredStyle: .ActionSheet)
        
        func alertAction(#title: String, withImagePickerController type: UIImagePickerControllerSourceType) -> UIAlertAction {
            return UIAlertAction(title: title, style: .Default) { (alert) -> Void in
                self.showImagePickerControllerWithType(type)
            }
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePickerActionSheet.addAction(alertAction(title: "Take Photo", withImagePickerController: .Camera))
        }
        imagePickerActionSheet.addAction(alertAction(title: "Choose Existing", withImagePickerController: .PhotoLibrary))
        imagePickerActionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(imagePickerActionSheet, animated: true, completion: nil)
    }

    
}

// MARK: - UIImagePickerController

extension ViewController: UIImagePickerControllerDelegate {
    
    func showImagePickerControllerWithType(type: UIImagePickerControllerSourceType) {
        let picker = imagePickerControllerWithType(type)
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerWithType(type: UIImagePickerControllerSourceType) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = type
        return picker;
    }

    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as UIImage
        let scaledImage = selectedPhoto.scaleImage(maxDimension: CGFloat(maxDimension))
        
        dismissViewControllerAnimated(true) {
            self.performImageRecognition(scaledImage)
        }
    }
    
    
}

// MARK: - Tesseract

extension ViewController: TesseractDelegate {
    
    func performImageRecognition(image: UIImage) {
        let tesseract = Tesseract()
        tesseract.language = TesseractLanguages
        tesseract.recognize()
        
        
    }
    
    // MARK: TesseractDelegate
    
    func progressImageRecognitionForTesseract(tesseract: Tesseract!) {
        //
    }
    
    func shouldCancelImageRecognitionForTesseract(tesseract: Tesseract!) -> Bool {
        return false;
    }
    
    
}

// MARK: - Scale Image

extension UIImage {
    
    func scaleImage(#maxDimension: CGFloat) -> UIImage {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        var scaleFactor: CGFloat
        
        let width = self.size.width;
        let height = self.size.height
        
        if width > height {
            scaleFactor = height / width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = width / height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        return scaleImage(size: scaledSize)
    }
    
    func scaleImage(size scaledSize: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(scaledSize)
        self.drawInRect(CGRectMake(0, 0, scaledSize.width, scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    
}

