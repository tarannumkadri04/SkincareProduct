//
//  ProductsListView.swift
//  BeautiProduct
//
//  Created by Tarannum on 23/02/24.
//

import SwiftUI
import Combine
import Foundation

/// A view displaying a list of beauty products.
struct ProductsListView: View {
    
    @StateObject private var viewModel = ProductsViewModel()
   
    var body: some View {
        
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.products.isEmpty {
                    Text("No products available")
                } else {
                    List(viewModel.products) { product in
                        ProductRowView(product: product)
                    }
                }
            }
            .navigationTitle("Beauty Products")
        }
        .onAppear {
            viewModel.fetchProducts()
        }
    }
}

/// A view displaying a row for a single product.
struct ProductRowView: View {
    
    /// The product to display in the row.
   let product: Product
       
    var body: some View {
            HStack {
                // Display product image
                AsyncImage(url: product.imageUrlSmall) { phase in
                    switch phase {
                    case .empty:
                        // Show placeholder image
                        Image("placeholder_image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50) // Adjust size as needed
                    case .success(let image):
                        // Show loaded image
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50) // Adjust size as needed
                    case .failure:
                        // Show error or fallback image
                        Image("error_image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50) // Adjust size as needed
                    @unknown default:
                        // Show placeholder image
                        Image("placeholder_image")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50) // Adjust size as needed
                    }
                }
                
                // Display other product information
                VStack(alignment: .leading) {
                    Text(product.productName ?? String())
                    Text(product.brandName ?? String())
                    Text("\(product.hazardRating ?? .zero)")
                }
            }
        }
}


#Preview {
    ProductsListView()
}
