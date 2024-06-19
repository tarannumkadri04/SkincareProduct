//
//  Product.swift
//  BeautiProduct
//
//  Created by Tarannum on 23/02/24.
//

import SwiftUI
import Combine

/// A structure representing a product.
struct Product: Identifiable, Decodable {
    
    /// The unique identifier of the product.
    let id = UUID()
    
    /// The name of the product.
    let productName: String?
    
    /// The brand name of the product.
    let brandName: String?
    
    /// The description of the product.
    let description: String?
    
    /// The URL to the small image of the product.
    let imageUrlSmall: URL?
    
    /// The URL to the large image of the product.
    let imageUrlLarge: URL?
    
    /// The category of the product.
    let productCategory: String?
    
    /// The hazard rating of the product.
    let hazardRating: Int?
    
    /// The hazard rating category of the product.
    let hazardRatingCategory: String?
    
    private enum CodingKeys: String, CodingKey {
       
        case id = "uuid"
        case productName = "product_name"
        case brandName = "brand_name"
        case description = "description"
        case imageUrlSmall = "image_url_small"
        case imageUrlLarge = "image_url_large"
        case productCategory = "product_category"
        case hazardRating = "hazard_rating"
        case hazardRatingCategory = "hazard_rating_category"
    }
    
    /// Initializes a new product by decoding it from the given decoder.
    /// - Parameter decoder: The decoder to read data from.
    /// - Throws: An error if the decoding fails.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.productName = try container.decode(String.self, forKey: .productName)
        self.brandName = try container.decode(String.self, forKey: .brandName)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.imageUrlSmall = try container.decodeIfPresent(URL.self, forKey: .imageUrlSmall)
        self.imageUrlLarge = try container.decodeIfPresent(URL.self, forKey: .imageUrlLarge)
        self.productCategory = try container.decode(String.self, forKey: .productCategory)
        self.hazardRating = try container.decode(Int.self, forKey: .hazardRating)
        self.hazardRatingCategory = try container.decode(String.self, forKey: .hazardRatingCategory)
    }
}
