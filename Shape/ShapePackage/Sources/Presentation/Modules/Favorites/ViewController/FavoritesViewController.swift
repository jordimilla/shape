import Foundation
import UIKit
import Domain
import Combine

class FavoritesViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: FavoritesViewModel
    var breedImages: [BreedImage] = []
    var collectionView: UICollectionView?
    
    var cancellables: Set<AnyCancellable> = []

    // MARK: - Inits
    
    public init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupViews()
        viewModel.fetchBreedImagesFromStored()
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedPictureCollectionViewCell.indentifier, for: indexPath) as? BreedPictureCollectionViewCell else {
            return UICollectionViewCell()
        }
        let image: BreedImage = breedImages[indexPath.row]
        cell.setup(image: image)
        cell.setCallback(callback: {[unowned self] (boolValue:Bool) in
            viewModel.setFavoriteImage(image: image)
        })
        return cell
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         print("User tapped on item \(indexPath.row)")
      }
}

