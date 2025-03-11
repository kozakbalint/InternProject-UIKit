//
//  MovieTableViewCell.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 11..
//

import Combine
import SDWebImage
import UIKit

class MovieTableViewCell: UITableViewCell {
    public static let identifier = "MovieTableViewCell"
    public static func register() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet var posterView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseLabel: UILabel!
    
    private var viewModel: MovieCellViewModel?
    private var cancellables: Set<AnyCancellable> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with viewModel: MovieCellViewModel) {
        self.viewModel = viewModel
        titleLabel?.text = viewModel.title
        releaseLabel?.text = viewModel.releaseYear
        posterView?.sd_setImage(with: viewModel.posterUrl, placeholderImage: UIImage(named: "placeholder"))
    }
}
