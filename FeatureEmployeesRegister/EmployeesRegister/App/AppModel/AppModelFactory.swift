//
//  AppModelFactory.swift
//  FeatureEmployeesRegister
//
//  Created by Дмитрий Воронин on 08.01.2022.
//

import Foundation

final class AppModelFactory {
    private let useCaseFactory: UseCaseFactory
    private let mode: Mode
    
    init(useCaseFactory: UseCaseFactory, mode: Mode) {
        self.useCaseFactory = useCaseFactory
        self.mode = mode
    }
    
    func employeesListAppModel(folderId: UUID?) -> EmployeesListAppModel {
        EmployeesListAppModel(departamentsStructureUseCase: useCaseFactory.deprtamentStructureUseCase(), mode: mode, folderId: folderId)
    }
}
