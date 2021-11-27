//
//  EmployessListViewModel.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation
import RxSwift

final class EmployeesListViewModel {
    
    // MARK: - Public Properties
    
    var viewState: Observable<ViewState> {
        viewStateSubject
    }
    
    // MARK: - Private(set) Properties
    
    private(set) var mode: Mode
    
    // MARK: - Private Properties
    
    private let appModel: EmployeesListAppModel
    private let viewStateSubject = BehaviorSubject<ViewState>(value: .loading)
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialize
    
    init(appModel: EmployeesListAppModel) {
        self.appModel = appModel
        self.mode = appModel.mode
        subscribeOnAppModel()
    }
    
    // MARK: - Public Methods
    
    func refresh() {
        
    }
    
    // MARK: - Private Methods
    
    private func subscribeOnAppModel() {
        appModel.state.subscribe(onNext: { [weak self] state in
            self?.updateViewState(state)
        }).disposed(by: disposeBag)
    }
    
    private func updateViewState(_ state: AppModelState) {
        switch state {
        case .loading:
            viewStateSubject.onNext(.loading)
        case .loaded(let structureResult):
            let structure = StrcutureViewModel(structureResult)
            viewStateSubject.onNext(.loaded(structure))
        case .error(let useCaseError):
            viewStateSubject.onNext(.error(.init(useCaseError: useCaseError)))
        }
    }
}
