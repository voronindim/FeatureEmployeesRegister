//
//  EmployeeTableViewCell.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import UIKit
import Kingfisher

class EmployeeTableViewCell: UITableViewCell {

    // MARK: - Model
    
    struct Model {
        let name: String
        let avatarUrl: URL?
        let position: String
        let isSelected: Bool?
    }
    
    // MARK: - Static Properties
    
    static let reuseIdentifier = "EmployeeTableViewCell"
    
    // MARK: - @IBOutlet
    
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var positionLabel: UILabel!
    @IBOutlet private var selectButton: UIButton!
    
    // MARK: - Public Properties
    
    var selectButtonDidTappedHandler: (() -> Void)?
    
    // MARK: - Public Methods
    
    func setViewState(_ model: Model) {
        userNameLabel.text = model.name
        positionLabel.text = model.position
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        if let url = model.avatarUrl {
            avatarImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person.fill")?.withTintColor(.gray))
        }
        if let isSelected = model.isSelected {
            selectButton.isHidden = false
            let image = isSelected ? UIImage(systemName: "minus.circle") : UIImage(systemName: "plus.circle")
            selectButton.setImage(image, for: .normal)
        } else {
            selectButton.isHidden = true
        }
    }
    
    @IBAction func selectAction(_ sender: Any) {
        selectButtonDidTappedHandler?()
    }
    
}
