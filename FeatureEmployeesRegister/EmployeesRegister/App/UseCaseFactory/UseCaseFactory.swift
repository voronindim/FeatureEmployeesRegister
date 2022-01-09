//
//  UseCaseFactory.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation

final class UseCaseFactory {
    
    private let gatewayFactory: GatewayFactory
    
    init(gatewayFactory: GatewayFactory) {
        self.gatewayFactory = gatewayFactory
    }
    
    func deprtamentStructureUseCase() -> DepartamentStructureUseCase {
        let useCase = DepartamentStructureUseCaseImplementation(gateway: gatewayFactory.departamentStrcuture())
        return useCase
    }
    
}
