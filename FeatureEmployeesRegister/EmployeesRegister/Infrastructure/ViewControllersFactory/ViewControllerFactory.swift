//
//  ViewControllerFactory.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation
import UIKit

final class ViewControllerFactory {
    
    private let viewModelFactory: ViewModelsFactory
    
    init(viewModelFactory: ViewModelsFactory) {
        self.viewModelFactory = viewModelFactory
    }
    
    func structureViewController(folderId: UUID?) -> StructureViewController {
        let viewController = StructureViewController()
        viewController.title = "Моя команда"
        viewController.tabBarItem.image = UIImage(systemName: "person.3")
        viewController.viewModel = viewModelFactory.strctureViewModel(folderId: folderId)
        return viewController
    }
    
}
