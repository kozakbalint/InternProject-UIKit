//
//  MovieDetailsViewModel.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 11..
//

import Foundation
import SDWebImage
import UIKit
import SwiftUI

class MovieDetailsViewModel {
    @Published var movie: Movie?
    
    func presentActivityViewController(from viewController: UIViewController, image: UIImage?) {
        guard let poster = image else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [poster], applicationActivities: nil)
        viewController.present(activityViewController, animated: true)
    }
    
    func presentRatingView(from viewController: UIViewController) {
        guard let id = movie?.id else { return }
        
        let ratingView = RatingView(movieId: id)
        let hostingController = UIHostingController(rootView: ratingView)
        hostingController.modalPresentationStyle = .pageSheet
        
        viewController.present(hostingController, animated: true)
    }
}
