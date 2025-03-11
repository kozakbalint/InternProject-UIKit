//
//  MainViewModel.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 11..
//

import Combine
import Foundation

class MainViewModel {
    @Published var movies: [Movie] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init () {
        fetchMovies()
    }
    
    func fetchMovies() {
        NetworkManager.shared.getPopularMovies(page: 1)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { movies in
                self.movies = movies.map { Movie(from: $0)}
            }
            .store(in: &cancellables)
    }
}
