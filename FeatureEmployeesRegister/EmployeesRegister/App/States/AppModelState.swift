//
//  AppModelState.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation

enum AppModelState {
    case loading
    case loaded(StructureResult)
    case error(UseCaseError)
}
