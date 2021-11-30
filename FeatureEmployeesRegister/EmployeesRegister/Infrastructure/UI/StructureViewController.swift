//
//  StructureViewController.swift
//  FeatureEmployeesRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import UIKit
import RxSwift

class StructureViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var viewModel: EmployeesListViewModel?
    var coordinator: Coordinator?
    var selectedHandler: ((SelectionItems) -> Void)?
    
    // MARK: - Private Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .onDrag
        tableView.sectionHeaderTopPadding = .zero
//        tableView.rowHeight = 80
        return tableView
    }()
    
    private let dataSource = StructureDataSource()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        registerCells()
        
        setupNavigationbar()
        setupRefreshControl()
        setupTableView()
        setupDataSource()
        
        subscribeOnViewModel()
    }
    
    // MARK: - Private Methods
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshActionHandler), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshActionHandler() {
        viewModel?.refresh()
    }
    
    private func endOfRefresing() {
        tableView.refreshControl?.endRefreshing()
    }
    
    private func subscribeOnViewModel() {
        viewModel?.viewState.subscribe(onNext: { [weak self] state in
            self?.updateView(state)
        }).disposed(by: disposeBag)
    }
    
    private func updateView(_ state: ViewState) {
        switch state {
        case .loading:
            break
        case .loaded(let structure):
            endOfRefresing()
            dataSource.setStructure(structure, mode: viewModel?.mode)
        case .error(_):
            endOfRefresing()
        }
    }
    
    private func setupNavigationbar() {
        title = "Моя команда"
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    private func setupDataSource() {
        dataSource.structureDidChangedHandler = { [weak self] in
            self?.tableView.reloadData()
        }
        dataSource.selectHandler = { [weak self] selectionItem in
            self?.selectedHandler?(selectionItem)
        }
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: EmployeeTableViewCell.reuseIdentifier, bundle: Bundle(for: EmployeeTableViewCell.self)), forCellReuseIdentifier: EmployeeTableViewCell.reuseIdentifier)
        
        tableView.register(UINib(nibName: DepartamentTableViewCell.reuseIdentifier, bundle: Bundle(for: DepartamentTableViewCell.self)), forCellReuseIdentifier: DepartamentTableViewCell.reuseIdentifier)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = dataSource
        view.addSubview(tableView)
        setConstraints()
    }
    
    private func setConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(tableView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }

    private func selectionWithShowModeType(indexPath: IndexPath) {
        guard let structure = dataSource.structure else { return }
        switch indexPath.section {
        case StrctureTableViewSection.departaments.rawValue:
            let folderId = structure.departaments[indexPath.row].id
            coordinator?.showStructureViewController(folderID: folderId)
        case StrctureTableViewSection.employees.rawValue:
            let userId = structure.employees[indexPath.row].id
            coordinator?.showPersonDetailsViewController(id: userId)
        case StrctureTableViewSection.selectedItems.rawValue:
            break
        default:
            assertionFailure("Выбарана default ячейка")
        }
    }
    
    private func selectionWithOneSelectedModeType(indexPath: IndexPath) {
        guard let structure = dataSource.structure else { return }
        switch indexPath.section {
        case StrctureTableViewSection.departaments.rawValue:
            let departamentId = structure.departaments[indexPath.row].id
            coordinator?.showStructureViewController(folderID: departamentId)
        case StrctureTableViewSection.employees.rawValue:
            let user = structure.employees[indexPath.row]
            selectedHandler?(.employee([user]))
        case StrctureTableViewSection.selectedItems.rawValue:
            break
        default:
            assertionFailure("Выбарана default ячейка")
        }
    }
    
}

// MARK: - UITableViewDelegate

extension StructureViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModel else { return }

        switch viewModel.mode {
        case .show:
            selectionWithShowModeType(indexPath: indexPath)
        case .oneSelected:
            selectionWithOneSelectedModeType(indexPath: indexPath)
        case .multiSelected:
            break
        }
    }
    
}
