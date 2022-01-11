//
//  ProductTableViewCell.swift
//  LeboncoinTechnicalTest
//
//  Created by hamza on 09/01/2022.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    private var imageLoader: ImageLoader?
    
    private var stackView: UIStackView {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.frame = self.contentView.frame
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(infoLabel)
        return stackView
    }
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageLoader = ImageLoader()
        self.contentView.addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 50),
            image.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configure(product: ProductViewModel) {
        if let img = product.smallImage {
            imageLoader?.load(from: img, completion: { imageData, error in
                guard let imageData = imageData else {
                    return
                }
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: imageData)
                }
            })
        }
        
        infoLabel.text = product.title
    }

}
