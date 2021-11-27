//
//  StructureDataSource.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation
import UIKit

final class StructureDataSource: NSObject {
    
    // MARK: - Constants
    
    struct Constants {
        static let sections: [StrctureTableViewSection] = [.selectedItems, .departaments, .employees]
    }
    
    var structureDidChangedHandler: (() -> Void)?
    var selectHandler: ((SelectionItems) -> Void)?
    
    // MARK: - Public Properties
    
    private(set) var structure: StrcutureViewModel? {
        didSet {
            structureDidChangedHandler?()
        }
    }
    
    private var mode: Mode?
    
    // MARK: - Public Methods
    
    func setStructure(_ structure: StrcutureViewModel, mode: Mode?) {
        self.structure = structure
        self.mode = mode
    }
    
    // MARK: - Private Methods
    
    private func createTableViewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case StrctureTableViewSection.selectedItems.rawValue:
            return UITableViewCell()
            
        case StrctureTableViewSection.departaments.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: DepartamentTableViewCell.reuseIdentifier, for: indexPath) as! DepartamentTableViewCell
            if let viewModel = structure?.departaments[indexPath.row] {
                cell.setViewState(DepartamentTableViewCell.Model(name: viewModel.name, isSelected: mode == .show ? nil : false))
                cell.selectButtonDidTappedHandler = { [weak self] in
                    guard let departament = self?.structure?.departaments[indexPath.row] else { return }
                    self?.selectHandler?(.folder([departament]))
                }
            }
            return cell
            
        case StrctureTableViewSection.employees.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.reuseIdentifier, for: indexPath) as! EmployeeTableViewCell
            if let viewModel = structure?.employees[indexPath.row] {
                cell.setViewState(EmployeeTableViewCell.Model(name: viewModel.name, avatarUrl: viewModel.avatarUrl, position: viewModel.position, isSelected: mode == .show ? nil : false))
                cell.selectButtonDidTappedHandler = { [weak self] in
                    guard let employee = self?.structure?.employees[indexPath.row] else { return }
                    self?.selectHandler?(.employee([employee]))
                }
            }
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDataSource

extension StructureDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let strcture = structure else { return 0 }
        
        switch section {
        case StrctureTableViewSection.departaments.rawValue:
            return strcture.departaments.count
        case StrctureTableViewSection.employees.rawValue:
            return strcture.employees.count
        case StrctureTableViewSection.selectedItems.rawValue:
            return 0
        default:
            assertionFailure("Число ячеек не совпало!")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        createTableViewCell(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case StrctureTableViewSection.selectedItems.rawValue:
            return nil
        case StrctureTableViewSection.departaments.rawValue:
            return "Отделы"
        case StrctureTableViewSection.employees.rawValue:
            return "Сотрудники"
        default:
            return nil
        }
        
    }
}
