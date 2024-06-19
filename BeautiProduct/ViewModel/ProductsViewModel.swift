//
//  ProductsViewModel.swift
//  BeautiProduct
//
//  Created by Tarannum on 23/02/24.
//

import SwiftUI
import Combine

/// View model responsible for managing products data and business logic.
class ProductsViewModel: ObservableObject {
    
    /// Published property to hold the list of products.
    @Published var products: [Product] = []
    
    /// Published property to indicate whether data is currently being loaded.
    @Published var isLoading = false
    
    /// The repository used to fetch products data.
    private let repository: ProductsRepository
    
    /// Initializes the view model with an optional repository.
    /// - Parameter repository: An optional `ProductsRepository`. Defaults to `ProductsDataRepository`.
    init(repository: ProductsRepository = ProductsDataRepository()) {
        self.repository = repository
    }
    
    /// Fetches products data from the repository.
    func fetchProducts() {
        isLoading = true
        repository.fetchProducts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { [weak self] products in
                self?.products = products
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    /// A set to hold cancellable objects for handling asynchronous tasks.
    private var cancellables: Set<AnyCancellable> = []
}
