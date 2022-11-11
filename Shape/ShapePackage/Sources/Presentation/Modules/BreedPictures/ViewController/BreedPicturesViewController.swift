import Foundation
import UIKit
import Domain
import Combine

class BreedPicturesViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: BreedPicturesViewModel
    var breedImages: [BreedImage] = []
    var collectionView: UICollectionView?
    
    var cancellables: Set<AnyCancellable> = []

    // MARK: - Inits
    
    public init(viewModel: BreedPicturesViewModel) {
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

extension BreedPicturesViewController: UICollectionViewDataSource {
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

extension BreedPicturesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         print("User tapped on item \(indexPath.row)")
      }
}
