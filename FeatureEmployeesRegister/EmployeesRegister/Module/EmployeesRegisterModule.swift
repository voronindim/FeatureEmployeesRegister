//
//  EmployeesRegisterModule.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation
import UIKit

public final class EmployeesRegisterModule {
    private let coordinator: Coordinator
    
    public init(navigationController: UINavigationController, mode: Mode, selectionHandler: ((PublicItem) -> Void)? = nil) {
        let departamentStructureUseCase = DepartamentStructureUseCaseImplementation()
        let appModel = EmployeesListAppModel(departamentsStructureUseCase: departamentStructureUseCase, mode: mode)
        let viewModelsFactory = ViewModelsFactory(appModel: appModel)
        let viewControllerFactory = ViewControllerFactory(viewModelFactory: viewModelsFactory)
        
        coordinator = Coordinator(
            navigationController: navigationController,
            viewControllerFactory: viewControllerFactory,
            selectionHandler: { item in
                switch item {
                case .folder(let array):
                    switch mode {
                    case .show:
                        break
                    case .oneSelected:
                        let folders = array.map({ PublicItem.Folder($0) })
                        selectionHandler?(.folders(folders))
                    case .multiSelected:
                        break
                    }
                case .employee(let array):
                    switch mode {
                    case .show:
                        break
                    case .oneSelected:
                        let employees = array.map({ PublicItem.Employee($0) })
                        selectionHandler?(.employees(employees))
                    case .multiSelected:
                        break
                    }
                }
            }
        )
        
    }
    
    public func start() {
        coordinator.showStructureViewController(folderID: nil)
    }
}


fileprivate extension PublicItem.Employee {
    init(_ model: Employee) {
        self.init(id: model.id, name: model.name, avatarUrl: model.avatarUrl)
    }
}

fileprivate extension PublicItem.Folder {
    init(_ model: Departament) {
        self.init(id: model.id, name: model.name)
    }
}
