//
//  ImageProcessingViewModel.swift
//  DetectFacialAbnormalities
//
//  Created by Saket Kumar on 23/07/24.
//


import CoreData
import UIKit

class ImageProcessingViewModel {
    private let visionService: VisionService
    private let coreDataManager: CoreDataManager
    private let Abnormalities: [Abnormality] = [.pimple, .acne, .darkCircle, .pimpleAndDarkCircle, .acneAndDarkCircle, .pimpleAndAcne]

    var images: [ImageEntity] = []

    init(visionService: VisionService = VisionService(), coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.visionService = visionService
        self.coreDataManager = coreDataManager
    }

    func processImages(_ uiImages: [UIImage], completion: @escaping () -> Void) {
        let context = coreDataManager.context

        let group = DispatchGroup()
        
        for uiImage in uiImages {
            group.enter()
            visionService.detectFace(in: uiImage) { faceDetected in
                guard let entity = NSEntityDescription.entity(forEntityName: "ImageEntity", in: context) else {
                    fatalError("Could not find entity description!")
                }

                let newImageEntity = ImageEntity(entity: entity, insertInto: context)
                newImageEntity.imageData = uiImage.pngData()
                newImageEntity.status = faceDetected ? "Processed" : "Invalid"
                if newImageEntity.status == "Processed" {
                    let randomIndex = Int.random(in: 0...5)
                    newImageEntity.abnormality = self.Abnormalities[randomIndex].rawValue
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.coreDataManager.saveContext()
            self.fetchImages(completion: completion)
        }
    }

    func fetchImages(completion: @escaping () -> Void) {
        let fetchRequest: NSFetchRequest<ImageEntity> = ImageEntity.fetchRequest()
        images = (try? coreDataManager.context.fetch(fetchRequest)) ?? []
        completion()
    }
}
