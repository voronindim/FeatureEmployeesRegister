//
//  ViewModelsFactory.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation

final class ViewModelsFactory {
    private let appModelFactory: AppModelFactory
    
    init(appModelFactory: AppModelFactory) {
        self.appModelFactory = appModelFactory
    }
    
    func strctureViewModel(folderId: UUID?) -> EmployeesListViewModel {
        let viewModel = EmployeesListViewModel(appModel: appModelFactory.employeesListAppModel(folderId: folderId))
        return viewModel
    }
}
