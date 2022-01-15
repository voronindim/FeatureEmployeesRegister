//
//  DepartamentStructureGateway.swift
//  FeatureEmployeesRegister
//
//  Created by Дмитрий Воронин on 08.01.2022.
//

import Foundation
import Networking

final class DepartamentStructureGateway {
    private let apiSession: AsyncGenericApi
    private let token: String
    
    init(apiSession: AsyncGenericApi, token: String) {
        self.apiSession = apiSession
        self.token = token
    }
    
    func structure(id: UUID?) async -> Result<StructureResult, GatewayError> {
        do {
            let gatewayResult = try await apiSession.fetch(type: GatewayResult.self, with: urlRequest(id: id))
            return .success(StructureResult(
                departaments: gatewayResult.departments.map({ Departament($0) }),
                employees: gatewayResult.employees.map({ Employee($0) }))
            )
        } catch {
            return .failure(.unknownError)
        }
    }
    
    private func urlRequest(id: UUID?) -> URLRequest {
        if let id = id {
            let urlString = baseUrl.appendingPathComponent("DepartmentStructure/structure?departmentId=\(id.uuidString.lowercased())").absoluteString.removingPercentEncoding!
            let url = URL(string: urlString)!
            return URLRequest(url: url).addToken(token: token)
        }
        let url = baseUrl.appendingPathComponent("DepartmentStructure/structure", isDirectory: false)
        return URLRequest(url: url).addToken(token: token)
    }
    
}

fileprivate struct GatewayResult: Decodable {
    let departments: [GatewayDepartament]
    let employees: [GatewayEmployee]
}

fileprivate struct GatewayDepartament: Decodable {
    let guid: String
    let name: String
}

fileprivate struct GatewayEmployee: Decodable {
    let guid: String
    let name: String
    let photoPath: String?
    let position: String?
}

fileprivate extension Departament {
    init(_ model: GatewayDepartament) {
        self.init(id: UUID(uuidString: model.guid)!, name: model.name)
    }
}

fileprivate extension Employee {
    init(_ model: GatewayEmployee) {
        self.init(
            id: UUID(uuidString: model.guid)!,
            name: model.name,
            avatarUrl: URL(string: model.photoPath ?? ""),
            position: model.position ?? ""
        )
    }
}
