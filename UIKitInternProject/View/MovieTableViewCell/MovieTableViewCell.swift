//
//  MovieTableViewCell.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 11..
//

import Combine
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
        posterView?.image = UIImage(systemName: "photo")
        cancellables.removeAll()
        bindViewModel()
        viewModel.fetchPoster()
    }
    
    private func bindViewModel() {
        viewModel?.$posterData
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                if let data = data {
                    self?.posterView?.image = UIImage(data: data)
                } else {
                    self?.posterView?.image = UIImage(systemName: "photo")
                }
            }
            .store(in: &cancellables)
    }
    
}
