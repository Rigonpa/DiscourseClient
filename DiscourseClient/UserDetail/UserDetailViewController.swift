//
//  UserDetailViewController.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 26/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Id: ", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var idValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var idStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [idLabel, idValue])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.isHidden = true
        return stackView
    }()
    
    lazy var nameNoEditableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Name: ", comment: "")
        return label
    }()
    
    lazy var nameNoEditableValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameNoEditableStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameNoEditableLabel, nameNoEditableValue])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.isHidden = true
        return stackView
    }()
    
    lazy var nameEditableLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Name: ", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameEditableValue: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = NSLocalizedString(" New name", comment: "")
        return textField
    }()
    
    lazy var nameEditableStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameEditableLabel, nameEditableValue])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.isHidden = true
        return stackView
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("Username: ", comment: "")
        return label
    }()
    
    lazy var usernameValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var usernameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usernameLabel, usernameValue])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.isHidden = true
        return stackView
    }()
    
    lazy var updateButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.isHidden = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Update", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 5.0
        btn.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    let viewModel: UserDetailViewModel
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        view = UIView()
        view.backgroundColor = .white
        
        view.addSubview(idStackView)
        view.addSubview(nameNoEditableStackView)
        view.addSubview(nameEditableStackView)
        view.addSubview(usernameStackView)
        view.addSubview(updateButton)
                
        NSLayoutConstraint.activate([
            idStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            idStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        NSLayoutConstraint.activate([
            nameNoEditableStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            nameNoEditableStackView.topAnchor.constraint(equalTo: idStackView.bottomAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            nameEditableStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            nameEditableStackView.topAnchor.constraint(equalTo: idStackView.bottomAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            usernameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            usernameStackView.topAnchor.constraint(equalTo: nameNoEditableStackView.bottomAnchor, constant: 8),
            usernameStackView.topAnchor.constraint(equalTo: nameEditableStackView.bottomAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            updateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            updateButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        
        let backLeftBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        backLeftBarButton.tintColor = .black
        navigationItem.leftBarButtonItem = backLeftBarButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    fileprivate func updateUI() {
        idStackView.isHidden = false
        idValue.text = "\(viewModel.idValue!)"
        usernameStackView.isHidden = false
        usernameValue.text = viewModel.usernameValue
        if let editName = viewModel.nameIsEditableBool {
            if editName {
                nameEditableStackView.isHidden = false
                updateButton.isHidden = false
            } else {
                nameNoEditableStackView.isHidden = false
                nameNoEditableValue.text = viewModel.nameNoEditableValue
            }
        }
    }
    
    fileprivate func showErrorFetchingSingleUserAlert(){
        let message = NSLocalizedString("Failed to present the user's details", comment: "")
        showAlert(message)
    }
    
    @objc func updateButtonTapped() {
        
    }
    
    @objc func backButtonTapped() {
        viewModel.backButtonIsTapped()
    }
}

extension UserDetailViewController: UserDetailViewDelegate {
    func singleUserFetched() {
        updateUI()
    }
    
    func errorFetchingSingleUser() {
        showErrorFetchingSingleUserAlert()
    }
    
    
}
