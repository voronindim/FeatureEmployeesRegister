//
//  GatewayFactory.swift
//  FeatureEmployeesRegister
//
//  Created by Дмитрий Воронин on 08.01.2022.
//

import Foundation
import Networking

final class GatewayFactory {
    private let apiSession: AsyncGenericApi
    
    init(apiSession: AsyncGenericApi) {
        self.apiSession = apiSession
    }

    func departamentStrcuture() -> DepartamentStructureGateway {
        let gateway = DepartamentStructureGateway(apiSession: apiSession)
        return gateway
    }
    
}
