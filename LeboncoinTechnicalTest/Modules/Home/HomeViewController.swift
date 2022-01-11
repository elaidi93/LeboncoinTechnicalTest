//
//  HomeViewController.swift
//  LeboncoinTechnicalTest
//
//  Created by hamza on 08/01/2022.
//

import UIKit
import Combine

class HomeViewController: BaseViewController {
    
    // MARK: - Variables:
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        // Register cell
        tableView.register(ProductTableViewCell.self,
                           forCellReuseIdentifier: "ProductCell")
        
        
        tableView.rowHeight = 100
        return tableView
    }()
    
    var selectedCategory = -1 {
        didSet {
            if selectedCategory == -1 {
                products?.removeAll()
                products = DBProductManager.shared.fetch()
            } else {
                products?.removeAll()
                products = DBProductManager.shared.fetch()?.filter{ $0.categoryId == selectedCategory }
            }
        }
    }
    
    var productWorker: ProductWorker? {
        didSet {
            productWorker?.fetchProducts()
        }
    }
    
    var categoryWorker: CategoryWorker? {
        didSet {
            categoryWorker?.fetchCategories()
        }
    }
    
    private var observers = Set<AnyCancellable>()
    private var products: [ProductViewModel]? = [] {
        didSet {
            products = products?.sorted(by: { $0.creationDate ?? Date() > $1.creationDate ?? Date() }).sorted(by: { $0.isUrgent ?? false && $1.isUrgent ?? false })
            tableView.reloadData()
        }
    }
    
    var demoMenu: UIMenu?
    private var categories: [CategoryViewModel]? {
        didSet {
            didTapShooseCategory()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        // TableView Delegates
        tableView.dataSource = self
        tableView.delegate = self
        
        // fetch data from Local
        products = DBProductManager.shared.fetch()
        categories = DBCategoryManager.shared.fetch()
        
        productWorker?.passthrough.sink { products in
            self.products = products
        }.store(in: &observers)
        
        categoryWorker?.passthrough.sink { categories in
            self.categories = categories
        }.store(in: &observers)
        
        // navigation item
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Catégories", menu: demoMenu)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // TableView Layout
        tableView.frame = self.view.safeAreaLayoutGuide.layoutFrame
        
    }
    
    @objc
    private func didTapShooseCategory () {
        
        guard let categories = categories
        else { return }
        
        var menuItems: [UIAction] {
            var actions = [UIAction]()
            actions.append(UIAction(title: "Tous", handler: { _ in
                self.selectedCategory = -1
            }))
            for category in categories {
                actions.append(UIAction(title: category.name ?? "", handler: { _ in
                    self.selectedCategory = category.id ?? -1
                }))
            }
            return actions
        }
        
        demoMenu = {
            return UIMenu(title: "Catégories", children: menuItems)
        }()
        navigationItem.rightBarButtonItem?.menu = demoMenu
    }
    
//    func inject(productWorker: ProductWorker, categoryWorker: CategoryWorker) {
//        self.productWorker = productWorker
//        self.categoryWorker = categoryWorker
//    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductTableViewCell,
              let products = products
        else {
            fatalError()
        }
        cell.configure(product: products[indexPath.row], categories: categories)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsVC = ProductDetailsViewController()
        detailsVC.product = products?[indexPath.row]
        self.present(UINavigationController(rootViewController: detailsVC), animated: true)
    }
    
}

