//
//  BeautiProductApp.swift
//  BeautiProduct
//
//  Created by Tarannum on 23/02/24.
//

import SwiftUI

/// The main entry point of the BeautiProduct application.
@main
struct BeautiProductApp: App {
    var body: some Scene {
        /// The main window group scene of the application.
        WindowGroup {
            ProductsListView()
        }
    }
}
