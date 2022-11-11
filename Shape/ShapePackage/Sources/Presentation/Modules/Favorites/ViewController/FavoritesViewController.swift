import Foundation
import UIKit
import Domain
import Combine

class FavoritesViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: FavoritesViewModel
    var breedImages: [BreedImage] = []
    var breedSections: [String] = []
    var filterArray: [BreedImage] = []
    
    var isFiltered: Bool = false
    
    let searchBar: UISearchBar = {
        return $0
    }(UISearchBar())
    
    let stackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .fill
        return $0
    }(UIStackView())
    
    var sectionCollectionView: UICollectionView?
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
        setupViews()
        setupContraints()
        setupBindings()
        viewModel.fetchBreedImagesFromStored()
    }
    
    @objc private func tapButtonFilter(sender: UIButton) {
        guard let breed = sender.titleLabel?.text else { return }
        isFiltered = true
        filterArray = breedImages.filter({ $0.breed == breed })
        collectionView?.reloadData()
    }
    
    @objc private func tapButtonRemoveFilter(sender: UIButton) {
        isFiltered = false
        collectionView?.reloadData()
    }
}

// MARK: - Layout
extension FavoritesViewController {
    private func setupViews() {
        view.backgroundColor = .black
        title = "Favorites"

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 4, bottom: 4, right: 4)
        layout.itemSize = CGSize(width: self.view.frame.width/3.25, height: self.view.frame.width/3.25)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(BreedPictureCollectionViewCell.self, forCellWithReuseIdentifier: BreedPictureCollectionViewCell.indentifier)
        collectionView?.backgroundColor = .black
        
        view.addSubview(searchBar)
        view.addSubview(collectionView ?? UICollectionView())
        
        searchBar.delegate = self
        collectionView?.dataSource = self
    }
    
    private func setupContraints() {
        
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor)
        
        collectionView?.anchor(top: searchBar.bottomAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor)
    }
}

// MARK: - Binding
extension FavoritesViewController {
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

// MARK: - UISearch
extension FavoritesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty){
            isFiltered = false
            self.collectionView?.reloadData()
        } else {
            isFiltered = true
            filterArray = breedImages.filter({ (breedImage: BreedImage) -> Bool in
                let titleMatch = breedImage.breed?.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return titleMatch != nil }
            )
            collectionView?.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltered {
            return filterArray.count
        } else {
            return breedImages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedPictureCollectionViewCell.indentifier, for: indexPath) as? BreedPictureCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        var image: BreedImage
        if isFiltered {
            image = filterArray[indexPath.row]
        } else {
            image = breedImages[indexPath.row]
        }
        
        cell.setup(image: image, hiddenTitle: false)
        cell.setCallback(callback: {[unowned self] (boolValue:Bool) in
            if isFiltered {
                filterArray.remove(at: indexPath.row)
            }
            viewModel.setFavoriteImage(image: image)
        })
        return cell
    }
}


