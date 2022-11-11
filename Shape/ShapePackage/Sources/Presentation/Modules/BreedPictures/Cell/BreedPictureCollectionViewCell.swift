import UIKit
import Domain
import SDWebImage

public final class BreedPictureCollectionViewCell: UICollectionViewCell {
    
    public static let indentifier = "BreedPictureCollectionViewCell"

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .yellow
        return button
    }()
    
    var hasFavorite: Bool?
    var valueFavoriteChanged:((Bool) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .black
        addSubview(imageView)
        addSubview(favoriteButton)
        setupContraints()
    }
    private func setupContraints() {
        imageView.anchor(top: self.topAnchor,
                          left: self.leftAnchor,
                          bottom: self.bottomAnchor,
                          right: self.rightAnchor)
        
        favoriteButton.anchor(bottom: self.imageView.bottomAnchor,
                              right: self.imageView.rightAnchor,
                              bottomConstant: 16,
                              rightConstant: 8)
        
    }
    
    func setup(image: BreedImage) {
        self.hasFavorite = image.hasFavorite
        imageView.sd_setImage(with: URL(string: image.imageUrl), placeholderImage: UIImage())
        setButtons(hasFavorite: self.hasFavorite ?? false)
    }
    
    func setButtons(hasFavorite: Bool) {
        if hasFavorite {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        favoriteButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
    }
    
    func setCallback(callback:@escaping (Bool) -> Void) {
        valueFavoriteChanged = callback
     }
    
    @objc private func handleMarkAsFavorite() {
        self.hasFavorite = !(self.hasFavorite ?? false)
        setButtons(hasFavorite: self.hasFavorite ?? false)
        valueFavoriteChanged?(self.hasFavorite ?? false)
    }
}
