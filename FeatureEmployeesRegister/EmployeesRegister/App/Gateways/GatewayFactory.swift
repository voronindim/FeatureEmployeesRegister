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
    private let token: String
    
    init(apiSession: AsyncGenericApi, token: String) {
        self.apiSession = apiSession
        self.token = token
    }

    func departamentStrcuture() -> DepartamentStructureGateway {
        let gateway = DepartamentStructureGateway(apiSession: apiSession, token: token)
        return gateway
    }
    
}
