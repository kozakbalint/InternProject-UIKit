//
//  Movie.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 11..
//

import Foundation
import TmdbNetworkManager

struct Movie: Identifiable {
    let adult: Bool
    let backdropPath: String?
    let genres: [Genre]
    let id: Int
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String?
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    var posterURL: URL? {
        if let posterPath = posterPath, !posterPath.isEmpty {
            return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        } else {
            return nil
        }
    }
    
    var releaseYear: String? {
        guard let releaseDate = releaseDate else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: releaseDate) else { return nil }
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    init(from movieResponse: MovieResponse) {
        self.adult = movieResponse.adult
        self.backdropPath = movieResponse.backdropPath
        self.genres = movieResponse.genreIds.map { Genre(rawValue: $0) ?? .unknown }
        self.id = movieResponse.id
        self.originalLanguage = movieResponse.originalLanguage
        self.originalTitle = movieResponse.originalTitle
        self.overview = movieResponse.overview
        self.popularity = movieResponse.popularity
        self.posterPath = movieResponse.posterPath
        self.releaseDate = movieResponse.releaseDate
        self.title = movieResponse.title
        self.video = movieResponse.video
        self.voteAverage = movieResponse.voteAverage
        self.voteCount = movieResponse.voteCount
    }
    
    init(from movieDetailsResponse: MovieDetailsResponse) {
        self.adult = movieDetailsResponse.adult
        self.backdropPath = movieDetailsResponse.backdropPath
        self.id = movieDetailsResponse.id
        self.originalLanguage = movieDetailsResponse.originalLanguage
        self.originalTitle = movieDetailsResponse.originalTitle
        self.overview = movieDetailsResponse.overview
        self.popularity = movieDetailsResponse.popularity
        self.posterPath = movieDetailsResponse.posterPath
        self.releaseDate = movieDetailsResponse.releaseDate
        self.title = movieDetailsResponse.title
        self.video = movieDetailsResponse.video
        self.voteAverage = movieDetailsResponse.voteAverage
        self.voteCount = movieDetailsResponse.voteCount
        
        if let genres = movieDetailsResponse.genres {
            self.genres = genres.map { Genre(rawValue: $0.id) ?? .unknown }
        } else {
            self.genres = []
        }
    }
}
