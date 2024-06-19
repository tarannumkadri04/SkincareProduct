//
//  ProductsDataRepository.swift
//  BeautiProduct
//
//  Created by Tarannum on 23/02/24.
//

import SwiftUI
import Combine

/// A protocol defining the interface for fetching products data.
protocol ProductsRepository {
    
    /// Fetches products data asynchronously.
    /// - Returns: A publisher emitting an array of `Product` objects or an error.
    func fetchProducts() -> AnyPublisher<[Product], Error>
}

/// A concrete implementation of `ProductsRepository` that fetches products data from a remote API.
class ProductsDataRepository: ProductsRepository {
    
    /// Fetches products data from a remote API.
    /// - Returns: A publisher emitting an array of `Product` objects or an error.
    func fetchProducts() -> AnyPublisher<[Product], Error> {
        
        // Construct the URL for fetching products data
        guard let url = URL(string: "https://td-ios-coding-challenge.s3.amazonaws.com/product_data/products.json") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        // Create a data task publisher to fetch data from the URL
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ProductsResponse.self, decoder: JSONDecoder())
            .map { $0.products }
            .mapError { error -> Error in
                // Handle decoding errors here
                debugPrint(error)
                return error
            }
            .eraseToAnyPublisher()
    }
}

/// A structure representing the response from the products API.
struct ProductsResponse: Decodable {
    
    let products: [Product] // Array of Product objects
    
    /// Coding keys for decoding the ProductsResponse object from JSON.
    enum CodingKeys: CodingKey {
        case products
    }
    
    /// Initializes a ProductsResponse object by decoding it from a decoder.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.products = try container.decode([Product].self, forKey: .products)
    }
}
