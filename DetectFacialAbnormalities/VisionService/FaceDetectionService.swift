//
//  FaceDetectionService.swift
//  DetectFacialAbnormalities
//
//  Created by Saket Kumar on 23/07/24.
//

import Foundation

import Vision
import UIKit

class VisionService {
    func detectFace(in image: UIImage, completion: @escaping (Bool) -> Void) {
        guard let cgImage = image.cgImage else { return }

        let request = VNDetectFaceRectanglesRequest { (request, error) in
            if let results = request.results as? [VNFaceObservation], !results.isEmpty {
                completion(true)
            } else {
                completion(false)
            }
        }

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            try? handler.perform([request])
        }
    }
    
    func detectFaceRealTime(in buffer: CVPixelBuffer, completion: @escaping (Bool) -> Void) {
        let request = VNDetectFaceRectanglesRequest { (request, error) in
            if let results = request.results as? [VNFaceObservation], !results.isEmpty {
                completion(true)
            } else {
                completion(false)
            }
        }
        
        let handler = VNImageRequestHandler(cvPixelBuffer: buffer, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            try? handler.perform([request])
        }
    }
}
