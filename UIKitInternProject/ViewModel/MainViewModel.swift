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
    @Published var filteredMovies: [Movie] = []
    @Published var searchText: String = ""
    @Published var genreFilters: Set<Genre> = []
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
            } receiveValue: { [weak self] movies in
                self?.movies = movies.map { Movie(from: $0)}
                self?.filteredMovies = self?.movies ?? []
            }
            .store(in: &cancellables)
    }
    
    func filterMoviesBySearchText() {
        filterMoviesByGenre()
        
        if searchText.isEmpty {
            filteredMovies = filteredMovies.isEmpty ? movies : filteredMovies
        } else {
            filteredMovies = filteredMovies.filter { movie in
                let title = movie.title ?? ""
                return title.localizedStandardContains(searchText)
            }
        }
    }
    
    func toggleGenreFilter(_ genre: Genre) {
        if genreFilters.contains(genre) {
            genreFilters.remove(genre)
        } else {
            genreFilters.insert(genre)
        }
        
        filterMoviesBySearchText()
    }
    
    func filterMoviesByGenre() {
        if genreFilters.isEmpty {
            filteredMovies = movies
            return
        }
        
        filteredMovies = movies.filter { movie in
            let movieGenres: Set<Genre> = Set(movie.genres)
            return !movieGenres.intersection(genreFilters).isEmpty
        }
    }
}
