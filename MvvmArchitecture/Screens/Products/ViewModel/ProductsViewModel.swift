//
//  ProductsViewModel.swift
//  MvvmArchitecture
//
//  Created by Vidhika Ahir on 03/10/23.
//

import Foundation


class ProductsViewModel {
    
    var productList : [ProductsModelElement] = []
    var productAdded : AddProduct?
    
    var eventHandler : ((_ event: Event) -> Void)? //Data binding closure
    func fetchProducts(){
        ApiHelper.shared.getService(modalType: [ProductsModelElement].self, type: EndPointItems.products) { response in
            self.eventHandler?(.loading)
            switch response {
            case .failure(let error):
                self.eventHandler?(.error(error))
            case .success(let productsList):
                self.productList = productsList;
                self.eventHandler?(.dataLoaded)
            }
            self.eventHandler?(.stopLoading)
        }
    }
    
    func addProduct(product : [String:String]){
        ApiHelper.shared.getService(modalType: AddProduct.self, type: EndPointItems.addProduct(product: product)) { response in
            self.eventHandler?(.loading)
            switch response {
            case .failure(let error):
                self.eventHandler?(.error(error))
                self.eventHandler?(.stopLoading)
                break
            case .success(let productAdded):
                self.productAdded = productAdded
                self.eventHandler?(.addProduct)
                self.eventHandler?(.stopLoading)
                break
            }
            
        }
    }
}

extension ProductsViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        case addProduct
    }
}
