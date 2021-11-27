//
//  Coordinator.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation
import UIKit

final class Coordinator {
    private let viewControllerFactory: ViewControllerFactory
    private let navigationController: UINavigationController
    private let selectionHandler: (SelectionItems) -> Void
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactory, selectionHandler: @escaping (SelectionItems) -> Void) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
        self.selectionHandler = selectionHandler
    }
    
    func popToRootViewController(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func popViewController(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
}

extension Coordinator {
    func showStructureViewController(folderID: UUID?) {
        let viewController = viewControllerFactory.structureViewController(folderId: folderID)
        viewController.coordinator = self
        viewController.selectedHandler = selectionHandler
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showPersonDetailsViewController(id: UUID) {
        
    }
}
