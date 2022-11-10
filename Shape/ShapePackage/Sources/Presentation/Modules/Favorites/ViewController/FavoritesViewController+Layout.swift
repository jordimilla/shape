import Foundation
import UIKit.UIBarButtonItem

extension FavoritesViewController {
    public func setupViews() {
        title = "Favorites"
        view.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.register(BreedTableViewCell.self, forCellReuseIdentifier: BreedTableViewCell.indentifier)
    }

    public func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor)
    }
}
