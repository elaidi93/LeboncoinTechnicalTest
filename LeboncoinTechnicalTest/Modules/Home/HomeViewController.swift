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
    private let tableView = UITableView()
    private var observer: AnyCancellable?
    private var products: [ProductResponse]? = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        // TableView Delegates
        tableView.dataSource = self
        
        // fetch products
        
        products = ProductWorker.shared.fetchProducts()
        observer = ProductWorker.shared.send.sink { products in
            self.products = products
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // TableView Layout
        tableView.frame = self.view.safeAreaLayoutGuide.layoutFrame
        
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Cell: \(products?[indexPath.row].title ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailsVC = ProductDetailsViewController()
        detailsVC.product = products?[indexPath.row]
        self.present(UINavigationController(rootViewController: detailsVC), animated: true)
    }
}

