//
//  ProductSection.swift
//  BeautiProduct
//
//  Created by Tarannum on 24/02/24.
//

import Foundation
import SwiftUI

/// A section containing a group of products with a common brand name.
struct ProductSection: Identifiable {
    
    /// The unique identifier of the product section.
    let id: UUID = UUID()
    
    /// The brand name associated with the products in the section.
    let brandName: String
    
    /// The array of products belonging to the section.
    let products: [Product]
}
