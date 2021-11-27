//
//  ViewModelsFactory.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation

final class ViewModelsFactory {
    private let appModel: EmployeesListAppModel
    
    init(appModel: EmployeesListAppModel) {
        self.appModel = appModel
    }
    
    func strctureViewModel(folderId: UUID?) -> EmployeesListViewModel {
        let viewModel = EmployeesListViewModel(appModel: appModel)
        return viewModel
    }
}
