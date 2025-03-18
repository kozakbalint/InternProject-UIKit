//
//  MovieDetailsViewController.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 11..
//

import SDWebImage
import UIKit

final class MovieDetailsViewController: UIViewController {
    var viewModel = MovieDetailsViewModel()
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setMovie(movie: Movie) {
        viewModel.movie = movie
    }
    
    @objc func handleTapGesture() {
        viewModel.presentActivityViewController(from: self, image: posterView.image)
    }
    
    @objc func presentRatingView() {
        viewModel.presentRatingView(from: self)
    }
}

private extension MovieDetailsViewController {
    func setupView() {
        title = viewModel.movie?.title
        navigationController?.navigationBar.prefersLargeTitles = false
        
        titleLabel.text = viewModel.movie?.title
        overviewLabel.text = viewModel.movie?.overview
        
        posterView.sd_setImage(with: viewModel.movie?.posterURL, placeholderImage: UIImage(systemName: "placeholder"))
        
        setupTapGesture()
        setupToolbar()
    }
    
    func setupTapGesture() {
        posterView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        posterView.addGestureRecognizer(tapGesture)
    }
    
    func setupToolbar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "star"),
            style: .plain,
            target: self,
            action: #selector(presentRatingView)
        )
    }
}
