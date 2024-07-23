//
//  ImageEntity+CoreDataProperties.swift
//  DetectFacialAbnormalities
//
//  Created by Saket Kumar on 23/07/24.
//
//

import Foundation
import CoreData


extension ImageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageEntity> {
        return NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
    }

    @NSManaged public var imageData: Data?
    @NSManaged public var status: String?
    @NSManaged public var abnormality: String?

}

extension ImageEntity : Identifiable {

}
