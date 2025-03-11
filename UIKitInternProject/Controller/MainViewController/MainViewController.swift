//
//  MainViewController.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 11..
//

import Combine
import UIKit

class MainViewController: UIViewController {
    var viewMpdel = MainViewModel()
    var cellViewModels = [MovieCellViewModel]()
    var tableView = UITableView()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindViewModel()
    }
    
    func setupView() {
        title = "Popular Movies"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        setupTableView()
    }
    
    func bindViewModel() {
        viewMpdel.$movies
            .receive(on: RunLoop.main)
            .sink { [weak self] movies in
                self?.cellViewModels = movies.map { MovieCellViewModel(movie: $0)}
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}
