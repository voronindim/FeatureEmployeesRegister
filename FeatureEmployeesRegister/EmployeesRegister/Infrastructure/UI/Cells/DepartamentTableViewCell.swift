//
//  DepartamentTableViewCell.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import UIKit

class DepartamentTableViewCell: UITableViewCell {

    // MARK: - Model
    
    struct Model {
        let name: String
        let isSelected: Bool?
    }
    
    // MARK: - Static Properties
    
    static let reuseIdentifier = "DepartamentTableViewCell"

    // MARK: - @IBOutlet
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var arrowImageView: UIImageView!
    @IBOutlet private var selectButton: UIButton!
    
    // MARK: - Public Properties
    
    var selectButtonDidTappedHandler: (() -> Void)?
    
    // MARK: - Public Methods
    
    func setViewState(_ model: Model) {
        nameLabel.text = model.name
        if let isSelected = model.isSelected {
            selectButton.isHidden = false
            arrowImageView.isHidden = true
            let image = isSelected ? UIImage(systemName: "minus.circle") : UIImage(systemName: "plus.circle")
            selectButton.setImage(image, for: .normal)
        } else {
            arrowImageView.isHidden = false
            selectButton.isHidden = true
        }
    }
    
    // MARK: - @IBAction
    
    @IBAction func selectAction(_ sender: Any) {
        selectButtonDidTappedHandler?()
    }
    
}
