//
//  ViewState.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation

enum ViewState {
    case loading
    case loaded(StrcutureViewModel)
    case error(ViewErrorType)
}
