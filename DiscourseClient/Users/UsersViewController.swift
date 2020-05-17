//
//  UsersViewController.swift
//  DiscourseClient
//
//  Created by Ricardo González Pacheco on 25/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        
        let viewFlowLayout = UICollectionViewFlowLayout()
        viewFlowLayout.itemSize = CGSize(width: 94, height: 124)
        viewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        viewFlowLayout.headerReferenceSize = CGSize(width: 375, height: 24)
        viewFlowLayout.minimumInteritemSpacing = 0
        viewFlowLayout.minimumLineSpacing = 19
        
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewFlowLayout)
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(UserItem.self, forCellWithReuseIdentifier: UserItem.cellIdentifier)
        collection.backgroundColor = .white
        return collection
    }()
    
    let viewModel: UsersViewModel
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupUI()
        viewModel.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    fileprivate func updateUI() {
        collectionView.reloadData()
    }
    
    fileprivate func showErrorFetchingUsersAlert() {
        let message = NSLocalizedString("Error when fetching users \nPlease try again later", comment: "")
        showAlert(message)
    }

}

extension UsersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath: indexPath.item)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension UsersViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let item = collectionView.dequeueReusableCell(withReuseIdentifier: UserItem.cellIdentifier, for: indexPath) as? UserItem,
            let cellViewModel = viewModel.setCellForRow(indexPath: indexPath.item) {
            item.viewModel = cellViewModel
            return item
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
