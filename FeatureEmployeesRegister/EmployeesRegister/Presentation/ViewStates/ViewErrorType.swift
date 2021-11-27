//
//  ViewErrorType.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation

enum ViewErrorType {
    case unknownError
}

extension ViewErrorType {
    init(useCaseError: UseCaseError) {
        switch useCaseError {
        case .unknownError:
            self = .unknownError
        }
    }
}
