//
//  MovieTableCell.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 12..
//

import Foundation

struct MovieTableCell {
    let title: String
    let releaseYear: String
    let posterURL: URL?
    
    init(from movie: Movie) {
        self.title = movie.title ?? ""
        self.releaseYear = movie.releaseYear ?? ""
        self.posterURL = movie.posterURL
    }
}
