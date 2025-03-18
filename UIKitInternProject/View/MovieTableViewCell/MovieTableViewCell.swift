//
//  MovieTableViewCell.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 11..
//

import Combine
import SDWebImage
import UIKit

final class MovieTableViewCell: UITableViewCell {
    public static let identifier = "MovieTableViewCell"
    public static func register() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    
    func setup(with viewModel: MovieCellViewModel) {
        titleLabel?.text = viewModel.title
        releaseLabel?.text = viewModel.releaseYear
        posterView?.sd_setImage(with: viewModel.posterUrl, placeholderImage: UIImage(named: "placeholder"))
    }
}
