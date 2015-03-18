//
//  ViewController.swift
//  OCR
//
//  Created by Александр Игнатьев on 17.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        var tesseract = Tesseract();
    }
    
    // MARK: - Actions

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
        imagePickerActionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel) { (alert) -> Void in })
        presentViewController(imagePickerActionSheet, animated: true, completion: nil)
    }
    
    // MARK: - Scale
    
    func scaleImage(image: UIImage, maxDimension: CGFloat) -> UIImage {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        var scaleFactor: CGFloat
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = image.size.width / image.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        image.drawInRect(CGRectMake(0, 0, scaledSize.width, scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    // MARK: - UIImagePickerController
    
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
    

}

extension ViewController: UIImagePickerControllerDelegate {
    //
}


