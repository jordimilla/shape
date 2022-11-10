import Foundation
import UIKit.UIBarButtonItem

extension ListBreedsViewController {
    public func setupViews() {
        view.backgroundColor = .black
        title = "Breeds"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.register(BreedTableViewCell.self, forCellReuseIdentifier: BreedTableViewCell.indentifier)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorites", style: .plain, target: self, action: #selector(addTapped))
    }

    public func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor)
    }
    
    @objc public func addTapped() {
        guard let navigation = self.navigationController else { return }
        viewModel.goToFavorites(navigationController: navigation)
    }
}
