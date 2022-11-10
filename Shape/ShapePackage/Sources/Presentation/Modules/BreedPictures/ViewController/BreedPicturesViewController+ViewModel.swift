import Foundation

extension BreedPicturesViewController {
    public func setupBindings() {
        viewModel.$breedImages
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.breedImages = items
                self?.collectionView?.reloadData()
            }
            .store(in: &cancellables)
    }
}
