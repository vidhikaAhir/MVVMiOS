//
//  ProductsViewController.swift
//  MvvmArchitecture
//
//  Created by Vidhika Ahir on 03/10/23.
//


import UIKit
import Foundation

class ProductsViewController: UIViewController {

    @IBOutlet weak var productTableView : UITableView!
    
    private var viewModel = ProductsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       productTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
       configuration()

    }

}


extension ProductsViewController {
    
    func configuration(){
        initViewController()
        observeEvent()
    }
    
    func initViewController(){
        viewModel.fetchProducts()
    }
    
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                print("start loading")
                break
            case .dataLoaded:
                DispatchQueue.main.async {
                    self?.productTableView.reloadData()
                }
                break
            case .stopLoading:
                print("stop loading")
                break
            case .error(let error):
                print("error --> \(String(describing: error))")
                break
            }
        }
    }
    
}


extension ProductsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = productTableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        let product = viewModel.productList[indexPath.row]
        cell.products = product
        return cell
    }
    
}
