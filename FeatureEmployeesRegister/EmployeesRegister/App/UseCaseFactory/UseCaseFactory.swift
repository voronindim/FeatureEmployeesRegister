//
//  UseCaseFactory.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation

final class UseCaseFactory {
    
    func deprtamentStructureUseCase() -> DepartamentStructureUseCase {
        let useCase = DepartamentStructureUseCaseImplementation()
        return useCase
    }
    
}
