//
//  ProductsModel.swift
//  MvvmArchitecture
//
//  Created by Vidhika Ahir on 03/10/23.
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productsModel = try? JSONDecoder().decode(ProductsModel.self, from: jsonData)

import Foundation

// MARK: - ProductsModelElement
struct ProductsModelElement: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: String
    let rating: Rating
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}

