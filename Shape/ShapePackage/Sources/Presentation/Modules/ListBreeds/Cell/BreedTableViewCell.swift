import UIKit
import Domain

public final class BreedTableViewCell: UITableViewCell {
    
    public static let indentifier = "BreedTableViewCell"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        setupContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContraints() {
        titleLabel.anchor(top: self.topAnchor,
                          left: self.leftAnchor,
                          bottom: self.bottomAnchor,
                          right: self.rightAnchor,
                          topConstant: 16,
                          leftConstant: 16,
                          bottomConstant: 16,
                          rightConstant: 90)
        
    }
    
    func setup(title: String) {
        titleLabel.text = title.capitalized
    }
}

