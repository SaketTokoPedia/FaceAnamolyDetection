//
//  ResultViewController.swift
//  DetectFacialAbnormalities
//
//  Created by Saket Kumar on 23/07/24.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var resultTableView: UITableView!
    var viewModel: ImageProcessingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCustomBackButton()
        
        let nib = UINib(nibName: "ResultTableViewCell", bundle: nil)
        resultTableView.register(nib, forCellReuseIdentifier: "customCell")
        
        resultTableView.delegate = self
        resultTableView.dataSource = self

        viewModel.fetchImages { [unowned self] in
            self.resultTableView.reloadData()
        }
    }
    
    private func setupCustomBackButton() {
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(customBackButtonTapped))
        
        navigationItem.leftBarButtonItem = backButton
    }

    @objc private func customBackButtonTapped() {
        CoreDataManager.shared.deleteAllRecords(entityName: "ImageEntity")
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? ResultTableViewCell
        
        guard let cell else { return UITableViewCell()}
        
        let imageEntity = viewModel.images[indexPath.row]
        
        cell.configureCell(data: imageEntity)
        return cell
    }
}
