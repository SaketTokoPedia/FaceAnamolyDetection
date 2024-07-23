//
//  ResultTableViewCell.swift
//  DetectFacialAbnormalities
//
//  Created by Saket Kumar on 23/07/24.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var selfieImageView: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var abnormalityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(data: ImageEntity) {
        if let imageData = data.imageData {
            selfieImageView.image = UIImage(data: imageData)
        }
        if let status = data.status {
            statusLabel.text = status
        }
        if let abnormality = data.abnormality {
            abnormalityLabel.text = "Abnormalities:- \(abnormality)"
        } else {
            abnormalityLabel.text = ""
        }
    }
    
}
