import UIKit
import Domain
import SDWebImage

public final class BreedPictureCollectionViewCell: UICollectionViewCell {
    
    public static let indentifier = "BreedPictureCollectionViewCell"

    private lazy var titleLabel: UILabel = {
        $0.font = .systemFont(ofSize: 15.0, weight: .regular)
        $0.lineBreakMode = .byWordWrapping
        $0.backgroundColor = .black
        $0.textColor = .white
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var imageView: UIImageView = {
        $0.contentMode = .scaleToFill
        return $0
    }(UIImageView())
    
    private lazy var favoriteButton: UIButton = {
        $0.tintColor = .yellow
        return $0
    }(UIButton())
    
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
        addSubview(titleLabel)
        addSubview(favoriteButton)
        setupContraints()
    }
    private func setupContraints() {
        imageView.anchor(top: self.topAnchor,
                          left: self.leftAnchor,
                          bottom: self.bottomAnchor,
                          right: self.rightAnchor)
        
        titleLabel.anchor(top: self.imageView.topAnchor,
                     left: self.imageView.leftAnchor,
                     right: self.imageView.rightAnchor,
                     topConstant: 4,
                     leftConstant: 8,
                     rightConstant: 8)
        
        favoriteButton.anchor(bottom: self.imageView.bottomAnchor,
                              right: self.imageView.rightAnchor,
                              bottomConstant: 16,
                              rightConstant: 8)
        
    }
    
    func setup(image: BreedImage, hiddenTitle: Bool? = true) {
        hasFavorite = image.hasFavorite
        titleLabel.text = image.breed?.capitalized
        imageView.sd_setImage(with: URL(string: image.imageUrl), placeholderImage: UIImage())
        setButtons(hasFavorite: self.hasFavorite ?? false)
        guard let hiddenLabel = hiddenTitle else { return }
        titleLabel.isHidden = hiddenLabel
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
        hasFavorite = !(hasFavorite ?? false)
        setButtons(hasFavorite: hasFavorite ?? false)
        valueFavoriteChanged?(hasFavorite ?? false)
    }
}
