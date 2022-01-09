//
//  EmployeesListAppModel.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation
import RxSwift

final class EmployeesListAppModel {
    
    // MARK: - Public Properties
    
    var state: Observable<AppModelState> {
        stateSubejct
    }
    
    // MARK: - Private(set) Properties
    
    private(set) var mode: Mode
    private var folderId: UUID?
    
    // MARK: - Private Properties
    
    private let departamentsStructureUseCase: DepartamentStructureUseCase
    private let stateSubejct = BehaviorSubject<AppModelState>(value: .loading)
    
    // MARK: - Initialize
    
    init(departamentsStructureUseCase: DepartamentStructureUseCase, mode: Mode, folderId: UUID?) {
        self.departamentsStructureUseCase = departamentsStructureUseCase
        self.mode = mode
        self.folderId = folderId
        update()
    }
    
    // MARK: - Public Methods
    
    func refresh() {
        update()
    }

    // MARK: - Private Methods
    
    private func update() {
        Task {
            let result = await departamentsStructureUseCase.structure(id: folderId)
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self.stateSubejct.onNext(.loaded(result))
                case .failure(let useCaseError):
                    self.stateSubejct.onNext(.error(useCaseError))
                }
            }
        }
    }
    
}
