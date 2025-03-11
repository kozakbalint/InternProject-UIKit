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
    
    @Published var posterData: Data?
    private var cancellables: Set<AnyCancellable> = []
    
    init(movie: Movie) {
        self.title = movie.title ?? ""
        self.releaseYear = movie.releaseYear ?? ""
        self.posterUrl = movie.posterURL ?? nil
    }
}
