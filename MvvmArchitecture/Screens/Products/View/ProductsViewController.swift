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
    
    @IBOutlet weak var addBtn: UIBarButtonItem!
    
    
    private var viewModel = ProductsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       productTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
       configuration()

    }

    @IBAction func addBtnAction(_ sender: Any) {
        viewModel.addProduct(product: ["title":"Vidhikaaa"])
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
                DispatchQueue.main.async {
                    self?.view.activityStartAnimating()
                }
               break
            case .dataLoaded:
                DispatchQueue.main.async {
                    self?.productTableView.reloadData()
                }
                break
            case .stopLoading:
                DispatchQueue.main.async {
                    self?.view.activityStopAnimating()
                }
                break
            case .addProduct:
                DispatchQueue.main.async {
                    //add toast
                    print(self?.viewModel.productAdded)
                }
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
