//
//  NetworkManager.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 11..
//

import Combine
import Foundation
import TmdbNetworkManager

class NetworkManager {
    static let shared = NetworkManager()
    private let tmdbNetworkManager: TmdbNetworkManager?
    
    
    private init() {
        guard let plistFile = Bundle.main.path(forResource: "Tmdb", ofType: "plist") else {
            fatalError("No Tmdb.plist file found")
        }
        
        let plist = NSDictionary(contentsOfFile: plistFile)
        
        guard let apiKey = plist?["TMDB_AUTH_TOKEN"] as? String else {
            fatalError("No TMDB_AUTH_TOKEN found in Tmdb.plist")
        }
        
        self.tmdbNetworkManager = TmdbNetworkManager(apiClient: APIClient(authToken: apiKey))
    }
    
    func getPopularMovies(page: Int) -> AnyPublisher<[MovieResponse], Error> {
        return tmdbNetworkManager?.getPopularMovies(page: page) ?? Empty<[MovieResponse], Error>().eraseToAnyPublisher()
    }
    
    func getTopRatedMovies(page: Int) -> AnyPublisher<[MovieResponse], Error> {
        return tmdbNetworkManager?.getTopRatedMovies(page: page) ?? Empty<[MovieResponse], Error>().eraseToAnyPublisher()
    }
    
    func searchMovies(query: String) -> AnyPublisher<[MovieResponse], Error> {
        return tmdbNetworkManager?.searchMovies(query: query) ?? Empty<[MovieResponse], Error>().eraseToAnyPublisher()
    }
    
    func getMovieDetails(movieId: Int) -> AnyPublisher<MovieDetailsResponse, Error> {
        return tmdbNetworkManager?.getMovieDetails(id: movieId) ?? Empty<MovieDetailsResponse, Error>().eraseToAnyPublisher()
    }
    
    func addRatingToMovie(movieId: Int, value: Double) -> AnyPublisher<RatingResponse, Error> {
        return tmdbNetworkManager?.addRatingToMovie(id: movieId, value: value) ?? Empty<RatingResponse, Error>().eraseToAnyPublisher()
    }
}
