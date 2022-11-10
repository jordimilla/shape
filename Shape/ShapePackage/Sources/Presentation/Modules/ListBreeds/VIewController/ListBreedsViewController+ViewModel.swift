import Foundation

extension ListBreedsViewController {
    public func setupBindings() {
        viewModel.$breeds
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.breeds = items
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}
