//
//  CategoriesViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController para representar el listado de categorías
class CategoriesViewController: UIViewController {
    let viewModel: CategoriesViewModel
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        table.rowHeight = 100
        table.rowHeight = UITableView.automaticDimension
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func viewDidLoad() {
        viewModel.viewDidLoad()
    }
    
    fileprivate func updateUI() {
        tableView.reloadData()
    }
    
    fileprivate func showErrorFetchingCategoriesAlert() {
        let message = NSLocalizedString("Error fetching categories\nPlease try again", comment: "")
        showAlert(message)
    }
}

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CategoriesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* Usando CategoriesCellViewModel pero no CategoryCell (ni .swift ni .xib)
         let cell = UITableViewCell()
         let cellViewModel = viewModel.setCellForRow(indexPath: indexPath.row)
         cell.textLabel?.text = cellViewModel?.textLabelName
         return cell
         */
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell,
            let cellViewModel = viewModel.setCellForRow(indexPath: indexPath.row) {

            cell.viewModel = cellViewModel
            return cell
        }
        fatalError()
    }
}

extension CategoriesViewController: CategoriesViewDelegate {
    
    func categoriesFetched() {
        updateUI()
    }
    
    func errorFetchingCategories() {
        showErrorFetchingCategoriesAlert()
    }
}
