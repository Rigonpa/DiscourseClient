//
//  UsersViewController.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 25/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    lazy var tableview: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UserCell.self, forCellReuseIdentifier: UserCell.cellIdentifier)
        table.backgroundColor = .white
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    let viewModel: UsersViewModel
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func viewDidLoad() {
        viewModel.viewDidLoad()
    }
    
    fileprivate func updateUI() {
        tableview.reloadData()
    }
    
    fileprivate func showErrorFetchingUsersAlert() {
        let message = NSLocalizedString("Error when fetching users \nPlease try again later", comment: "")
        showAlert(message)
    }

}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UsersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.cellIdentifier, for: indexPath) as? UserCell,
            let cellViewModel = viewModel.setCellForRow(indexPath: indexPath.row) {
            cell.viewModel = cellViewModel
            return cell
        }
        fatalError()
    }
}

extension UsersViewController: UsersViewDelegate {
    
    func usersFetched() {
        updateUI()
    }
    
    func errorFetchingUsers() {
        showErrorFetchingUsersAlert()
    }
    
    
}
