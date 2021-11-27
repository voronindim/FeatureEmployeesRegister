//
//  DepartamentStructureUseCase.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation

protocol DepartamentStructureUseCase {
    func structure(id: UUID?) async -> Result<StructureResult, UseCaseError>
}
