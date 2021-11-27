//
//  DepartamentStructureUseCaseEmplementation.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation

final class DepartamentStructureUseCaseImplementation: DepartamentStructureUseCase {
    func structure(id: UUID?) async -> Result<StructureResult, UseCaseError> {
        .failure(.unknownError)
    }
}
