//
//  ProductDetailsViewController.swift
//  LeboncoinTechnicalTest
//
//  Created by hamza on 09/01/2022.
//

import UIKit

class ProductDetailsViewController: BaseViewController {
    
    var product: ProductViewModel?
    
    private var scrollView = UIScrollView()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        fillForm()
    }
    
    private func fillForm() {
        if let img = product?.thumbImage {
            ImageLoader.shared.load(from: img, completion: { imageData, error in
                guard let imageData = imageData else {
                    return
                }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: imageData)
                }
            })
        }
        
        if let title = product?.title {
            addLabel(with: title)
        }
        if let description = product?.description {
            addLabel(with: description)
        }
        if let cerationDate = product?.creationDate {
            addLabel(with: "Créer en: \(cerationDate)")
        }
        if let price = product?.price {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            addLabel(with: "Prix: \(formatter.string(from: NSNumber(value: price)) ?? "")")
        }
    }
    
    private func addLabel(with text: String) {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        label.textAlignment = .left
        stackView.addArrangedSubview(label)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = self.view.safeAreaLayoutGuide.layoutFrame
        imageConstraints()
        stackConstraints()
    }

    private func imageConstraints() {
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
    
    private func stackConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}
