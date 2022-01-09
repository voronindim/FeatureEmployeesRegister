//
//  DepartamentStructureUseCaseEmplementation.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation

final class DepartamentStructureUseCaseImplementation: DepartamentStructureUseCase {
    private let gateway: DepartamentStructureGateway
    
    init(gateway: DepartamentStructureGateway) {
        self.gateway = gateway
    }
    
    func structure(id: UUID?) async -> Result<StructureResult, UseCaseError> {
        switch await gateway.structure(id: id) {
        case .success(let result):
            return .success(result)
        case .failure(_):
            return .failure(.unknownError)
        }
    }
}
