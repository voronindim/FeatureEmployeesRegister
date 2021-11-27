//
//  StructureViewModel.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation

struct StrcutureViewModel {
    let departaments: [Departament]
    let employees: [Employee]
    let hasMore: Bool
}


extension StrcutureViewModel {
    init(_ model: StructureResult) {
        self.init(
            departaments: model.departaments,
            employees: model.employees,
            hasMore: model.hasMore
        )
    }
}
