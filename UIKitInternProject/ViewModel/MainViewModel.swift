//
//  MainViewModel.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 11..
//

import Combine
import Foundation

protocol MainViewModelProtocol {
    var didUpdateMovies: ((_ movies: [Movie]) -> Void)? { get set }
    var didUpdateFilteredMovies: ((_ filteredMovies: [Movie]) -> Void)? { get set }
    var didUpdateSearchText: ((_ searchText: String) -> Void)? { get set }
}

final class MainViewModel: MainViewModelProtocol {
    var didUpdateMovies: ((_ movies: [Movie]) -> Void)?
    var didUpdateFilteredMovies: ((_ filteredMovies: [Movie]) -> Void)?
    var didUpdateSearchText: ((_ searchText: String) -> Void)?
    
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    var searchText: String = ""
    var genreFilters: Set<Genre> = []
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchMovies() {
        NetworkManager.shared.getPopularMovies(page: 1)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] movies in
                self?.didUpdateMovies?(movies.map {Movie(from: $0)})
                self?.didUpdateFilteredMovies?(self?.movies ?? [])
            }
            .store(in: &cancellables)
    }
    
    func filterMoviesBySearchText() {
        filterMoviesByGenre()
        
        if searchText.isEmpty {
            filteredMovies = filteredMovies.isEmpty && genreFilters.isEmpty ? movies : filteredMovies
        } else {
            filteredMovies = filteredMovies.filter {
                let title = $0.title ?? ""
                return title.localizedStandardContains(searchText)
            }
        }
        
        self.didUpdateFilteredMovies?(filteredMovies)
    }
    
    func toggleGenreFilter(_ genre: Genre) {
        if genreFilters.contains(genre) {
            genreFilters.remove(genre)
        } else {
            genreFilters.insert(genre)
        }
        
        filterMoviesByGenre()
    }
    
    func filterMoviesByGenre() {
        if genreFilters.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter {
                let movieGenres: Set<Genre> = Set($0.genres)
                return !movieGenres.intersection(genreFilters).isEmpty
            }
        }
        
        self.didUpdateFilteredMovies?(filteredMovies)
    }
    
    func isGenreSelected(genre: Genre) -> Bool {
        return genreFilters.contains(genre)
    }
}
