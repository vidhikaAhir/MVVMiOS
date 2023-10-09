//
//  ApiHelper.swift
//  MvvmArchitecture
//
//  Created by Vidhika Ahir on 03/10/23.
//

import Foundation

typealias handler<T> = (Result<T, DataError>) -> Void

class ApiHelper {
    
    static let shared = ApiHelper()
    
    private init() {}
    
    func getService<T:Codable>(
        modalType: T.Type,
        type: EndPointType,
        completionHandler : @escaping handler<T>
    ){
        guard let url = type.url else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.method.rawValue
        request.allHTTPHeaderFields = type.headers
        if let parameters = type.body {
            request.httpBody = try? JSONEncoder().encode(parameters)
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            do{
                let productsModel = try JSONDecoder().decode(modalType, from: data)
                completionHandler(.success(productsModel))
                
            }catch{
                completionHandler(.failure(.invalidDecoding))
            }
            
        }.resume()
        
    }
    
    //    func fetchList( completionHandler : @escaping handler){
    //
    //        guard let url = URL(string: Constants.API.productURL) else { return }
    //
    //        URLSession.shared.dataTask(with: url) { data, response, error in
    //
    //            guard let data else {
    //                completionHandler(.failure(.invalidData))
    //                return
    //            }
    //
    //            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
    //                completionHandler(.failure(.invalidResponse))
    //                return
    //            }
    //            do{
    //
    //                let productsModel = try JSONDecoder().decode([ProductsModelElement].self, from: data)
    //                completionHandler(.success(productsModel))
    //
    //            }catch{
    //                completionHandler(.failure(.invalidDecoding))
    //            }
    //
    //        }.resume()
    //    }
    
    var commonHeaders : [String : String] = [
        "content-type" : "application/json"
    ]
}


enum DataError : Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case invalidDecoding
    case error(Error)
    
}
