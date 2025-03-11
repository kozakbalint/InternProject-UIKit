//
//  MovieCellViewModel.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 11..
//

import Combine
import Foundation

class MovieCellViewModel {
    var title: String
    var releaseYear: String
    var posterUrl: URL?
    
    init(cell: MovieTableCell) {
        self.title = cell.title
        self.releaseYear = cell.releaseYear
        self.posterUrl = cell.posterURL ?? nil
    }
}
