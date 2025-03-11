//
//  RatingViewModel.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 12..
//

import Combine
import Foundation
import TmdbNetworkManager

class RatingViewModel: ObservableObject {
    @Published var rating: Int = 0
    @Published var success: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    func sendRating(movieId: Int, rating: Int) {
        NetworkManager.shared.addRatingToMovie(movieId: movieId, value: Double(rating))
            .receive(on: RunLoop.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            } receiveValue: { [weak self] response in
                if response.success {
                    self?.success = true
                }
            }
            .store(in: &cancellables)
    }
}
