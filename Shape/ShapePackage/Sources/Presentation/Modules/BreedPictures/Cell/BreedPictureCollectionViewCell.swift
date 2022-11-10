import UIKit
import Domain
import SDWebImage

public final class BreedPictureCollectionViewCell: UICollectionViewCell {
    
    public static let indentifier = "BreedPictureCollectionViewCell"

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(imageView)
        setupContraints()
    }
    private func setupContraints() {
        imageView.anchor(top: self.topAnchor,
                          left: self.leftAnchor,
                          bottom: self.bottomAnchor,
                          right: self.rightAnchor,
                          topConstant: 16,
                          leftConstant: 16,
                          bottomConstant: 16,
                          rightConstant: 16)
        
    }
    
    func setup(imageUrl: String) {
        imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage())
    }
}
