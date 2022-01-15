//
//  EmployeesRegisterModule.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation
import UIKit
import Networking

public final class EmployeesRegisterModule {
    private let coordinator: Coordinator
    
    public init(navigationController: UINavigationController, mode: Mode, apiSession: AsyncGenericApi, token: String,  selectionHandler: ((PublicItem) -> Void)? = nil) {
        let gatewayFactory = GatewayFactory(apiSession: apiSession, token: token)
        let useCaseFactory = UseCaseFactory(gatewayFactory: gatewayFactory)
        let appModelFactory = AppModelFactory(useCaseFactory: useCaseFactory, mode: mode)
        let viewModelsFactory = ViewModelsFactory(appModelFactory: appModelFactory)
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
