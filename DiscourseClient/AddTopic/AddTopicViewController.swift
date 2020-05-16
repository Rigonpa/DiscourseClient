//
//  AddTopicViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController representando un formulario de entrada para crear un topic
class AddTopicViewController: UIViewController {
    
    lazy var imageUrlTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .line
        tf.placeholder = NSLocalizedString("Insert topic image url and tap Submit", comment: "")
        return tf
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.placeholder = NSLocalizedString("Insert topic title and tap Submit", comment: "")

        return textField
    }()

    let viewModel: AddTopicViewModel

    init(viewModel: AddTopicViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(imageUrlTextField)
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            imageUrlTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageUrlTextField.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            imageUrlTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])

        let submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle(NSLocalizedString("Submit", comment: ""), for: .normal)
        submitButton.backgroundColor = .cyan
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)

        view.addSubview(submitButton)
        NSLayoutConstraint.activate([
            submitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            submitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            submitButton.topAnchor.constraint(equalTo: imageUrlTextField.bottomAnchor, constant: 8)
        ])

        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(cancelButtonTapped))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc fileprivate func cancelButtonTapped() {
        viewModel.cancelButtonTapped()
    }

    @objc fileprivate func submitButtonTapped() {
        guard let text = textField.text, !text.isEmpty, let imageUrlString = imageUrlTextField.text else { return }
        viewModel.submitButtonTapped(title: text, imageUrl: imageUrlString)
    }

    fileprivate func showErrorAddingTopicAlert() {
        let message = NSLocalizedString("Error adding topic\nPlease try again later", comment: "")
        showAlert(message)
    }
}

extension AddTopicViewController: AddTopicViewDelegate {
    func errorAddingTopic() {
        showErrorAddingTopicAlert()
    }
}
