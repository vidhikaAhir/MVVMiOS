//
//  ProductsViewModel.swift
//  MvvmArchitecture
//
//  Created by Vidhika Ahir on 03/10/23.
//

import Foundation


class ProductsViewModel {
    
    var productList : [ProductsModelElement] = []
    
    var eventHandler : ((_ event: Event) -> Void)? //Data binding closure
    func fetchProducts(){
        ApiHelper.shared.fetchList { response in
            
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
}

extension ProductsViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
