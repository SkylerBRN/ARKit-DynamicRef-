//
//  CameraViewConroller.swift
//  ARKitImageDetection
//
//  Created by Skyler Brown on 6/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import ARKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    var testImage: UIImage?
    var refImage: ARReferenceImage!
    @IBOutlet weak var takePicButton: UIButton!
    @IBOutlet weak var loadImageButton: UIButton!
    
    //MARK: Actions
    // Take picture from camera to be used as UIImage for dynamic reference.
    @IBAction func getPicFromCamera(_ sender: UIButton) {
        
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        
        present (imagePickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Guard in case testImage fails to be populated by info key
        guard let testImage = info[.originalImage] as? UIImage else
        {
            fatalError ("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
         dismiss(animated: true, completion: nil)
    }
    
    /// Adds ARReferenceImage to detectionImages "on-the-fly"
    func addARReferenceImageFromCamera () {
        
        guard let imageToCIImage = CIImage(image: testImage!),
            let cgImage = convertCIImageToCGImage(inputImage: imageToCIImage) else { return }
        let arImage = ARReferenceImage(cgImage, orientation: CGImagePropertyOrientation.up, physicalWidth: 0.22) // assuming A4 page
        let refImage = arImage
        
        refImage.name = "TheTextbookPage"
        
        // arConfig.trackingImages = [arImage]
    }
    
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage? {
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(inputImage, from: inputImage.extent) {
            return cgImage
        }
        return nil
    }
    
/*   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIButton, button == loadImageButton else {
            return
        }
        
        
        let destination = segue.destination as! ViewController
        destination.theImage = refImage
        
    }
 */
    
    /*
    @IBAction func loadImage(_ sender: UIButton) {
        
        guard let sender = loadImageButton else {
            return
        }
        
        let vc = ViewController()
        vc.theImage = refImage
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    */
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Code after setup
    }
    
}
