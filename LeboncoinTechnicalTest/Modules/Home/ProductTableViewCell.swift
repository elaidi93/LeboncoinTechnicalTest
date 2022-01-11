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
        stackView.distribution = .fill
        stackView.alignment = .firstBaseline
        stackView.frame = self.contentView.frame
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(labelsStackView)
        return stackView
    }
    
    private var labelsStackView: UIStackView {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(priceLabel)
        return stackView
    }
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let formatter = NumberFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        formatter.numberStyle = .currency
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
            image.heightAnchor.constraint(equalToConstant: 60),
            image.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configure(product: ProductViewModel, categories: [CategoryViewModel]?) {
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
        
        titleLabel.text = product.title
        if let price = product.price,
           let formattedPrice = formatter.string(from: NSNumber(value: price)) {
            priceLabel.text = "Prix: \(formattedPrice)"
        }
        
        if let category = categories?.first(where: { $0.id == product.categoryId })?.name {
               categoryLabel.text = "Catégorie\(category)"
           }
        
    }
    
}
