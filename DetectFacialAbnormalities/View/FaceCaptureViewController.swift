//
//  FaceCaptureViewController.swift
//  DetectFacialAbnormalities
//
//  Created by Saket Kumar on 23/07/24.
//

import UIKit
import AVFoundation

class FaceCaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    var selectedImages: [UIImage] = []
    var viewModel: ImageProcessingViewModel!
    private var isCameraStopped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ImageProcessingViewModel()
        imagePicker.delegate = self
    }
    
    @IBAction func captureImage(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.cameraDevice = .front
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func selectImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImages.append(image)
            if selectedImages.count == 2 {
                viewModel.processImages(selectedImages) {
                    self.showResults()
                }
                selectedImages = []
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func showResults() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let resultsVC = storyboard.instantiateViewController(identifier: "ResultViewController") as? ResultViewController {
            resultsVC.viewModel = viewModel
            navigationController?.pushViewController(resultsVC, animated: true)
        }
    }
}
