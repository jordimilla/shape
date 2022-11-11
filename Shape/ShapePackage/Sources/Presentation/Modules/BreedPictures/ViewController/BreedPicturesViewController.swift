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

// MARK: - Layout
extension BreedPicturesViewController {
    private func setupViews() {
        
        view.backgroundColor = .black
        title = viewModel.breed.name.capitalized

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 4, bottom: 4, right: 4)
        layout.itemSize = CGSize(width: self.view.frame.width/3.25, height: self.view.frame.width/3.25)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(BreedPictureCollectionViewCell.self, forCellWithReuseIdentifier: BreedPictureCollectionViewCell.indentifier)
        collectionView?.backgroundColor = .black
        view.addSubview(collectionView ?? UICollectionView())
        
        collectionView?.dataSource = self
        
    }
}

// MARK: - Binding
extension BreedPicturesViewController {
    private func setupBindings() {
        viewModel.$breedImages
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                self?.breedImages = items
                self?.collectionView?.reloadData()
            }
            .store(in: &cancellables)
    }
}

// MARK: - UICollectionViewDataSource
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
