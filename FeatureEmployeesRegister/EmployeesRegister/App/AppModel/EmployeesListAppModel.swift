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
    
    // MARK: - Private Properties
    
    private let departamentsStructureUseCase: DepartamentStructureUseCase
    private let stateSubejct = BehaviorSubject<AppModelState>(value: .loading)
    
    // MARK: - Initialize
    
    init(departamentsStructureUseCase: DepartamentStructureUseCase, mode: Mode) {
        self.departamentsStructureUseCase = departamentsStructureUseCase
        self.mode = mode
        self.stateSubejct.onNext(.loaded(mock))
    }
    
    // MARK: - Public Methods
    
    func openDepartament(id: UUID?) {
        
    }
    
    // MARK: - Private Methods
    
    
    
}

fileprivate var mock = StructureResult(
    departaments: dep,
    employees: [
        .init(id: UUID(), name: "askljd lasjdf", avatarUrl: nil, position: "position"),
        .init(id: UUID(), name: "askljd lasjkljd lasjkljd lasjkljd lasjkljd lasjkljd lasj kljd lasjkljd lasj kljd lasjdf", avatarUrl: nil, position: "position"),
        .init(id: UUID(), name: "askljd lasjdf", avatarUrl: nil, position: "position"),
        .init(id: UUID(), name: "askljd lasjdf", avatarUrl: nil, position: "position"),
        .init(id: UUID(), name: "askljd lasjdf", avatarUrl: nil, position: "position"),
        .init(id: UUID(), name: "askljd lasjdf", avatarUrl: nil, position: "position"),
        .init(id: UUID(), name: "askljd lasjdf", avatarUrl: nil, position: "position")
    ],
    hasMore: true
)

fileprivate var dep: [Departament] = [
    .init(id: UUID(), name: "alksj lksajdflk aj askdjf as"),
    .init(id: UUID(), name: "alksj lksajdflk asl;fj salsdf dsfdfj askdjf asalksj lksajdflk asl;fj salsdf dsfdfj askdjf asalksj lksajdflk asl;fj salsdf dsfdfj askdjf asalksj lksajdflk asl;fj salsdf dsfdfj askdjf asalksj lksajdflk asl;fj salsdf dsfdfj askdjf asalksj lksajdflk asl;fj salsdf dsfdfj askdjf asalksj lksajdflk asl;fj salsdf dsfdfj askdjf asalksj lksajdflk asl;fj salsdf dsfdfj askdjf as"),
    .init(id: UUID(), name: "alksj sdfsf asl;fj saldfj askdjf as"),
    .init(id: UUID(), name: "alksj lksajdflk asl;fj saldfj askdjf as"),
    .init(id: UUID(), name: "alksj lksajdflk s asl;fj saldfj askdjf as"),
    .init(id: UUID(), name: "alksj lksajdflk aaf sdf sadf sdf sl;fj saldfj askdjf as"),
    .init(id: UUID(), name: "alksj lksajdaldfj askdjf as"),
    .init(id: UUID(), name: "alksj lksajdflk asl;fj  askdjf as")
]

