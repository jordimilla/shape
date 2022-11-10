import Foundation
import UIKit.UICollectionView

extension BreedPicturesViewController {
    public func setupViews() {
        
        view.backgroundColor = .black
        title = viewModel.breed.name.capitalized

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 4, bottom: 4, right: 4)
        layout.itemSize = CGSize(width: 120, height: 120)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(BreedPictureCollectionViewCell.self, forCellWithReuseIdentifier: BreedPictureCollectionViewCell.indentifier)
        collectionView?.backgroundColor = .black
        view.addSubview(collectionView ?? UICollectionView())
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
}
