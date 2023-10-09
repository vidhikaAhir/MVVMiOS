//
//  HTTPMethods.swift
//  MvvmArchitecture
//
//  Created by Vidhika Ahir on 05/10/23.
//

import Foundation

enum HTTPMethods : String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var url : URL? { get }
    var path : String { get }
    var baseUrl : String { get }
    var method : HTTPMethods { get }
    var body : Encodable? { get }
    var headers : [String : String] { get }
    
}

enum EndPointItems {
    case products
    case addProduct( product : Encodable)
}

extension EndPointItems : EndPointType {
    
    var body: Encodable? {
        switch self {
        case .products:
            return nil
        case .addProduct(let product):
            return product
        }
    }
    
    var headers: [String : String] {
        ApiHelper.shared.commonHeaders
    }
    
    
    var path: String {
        switch self {
        case .products:
            return "products"
        case .addProduct:
            return "products/add"
        }
    }
    
    var baseUrl: String {
        
        switch self {
        case .products:
            return "https://fakestoreapi.com/"
        case .addProduct(let product):
            return "https://dummyjson.com/"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseUrl)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .products:
            return .get
        case .addProduct:
            return .post
        }
    }
    
        
}

