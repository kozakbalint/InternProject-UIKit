//
//  MainViewController.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 11..
//

import Combine
import UIKit

final class MainViewController: UIViewController {
    var viewModel = MainViewModel()
    var cellViewModels = [MovieCellViewModel]()
    var searchController = UISearchController()
    var tableView = UITableView()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindViewModel()
        viewModel.fetchMovies()
    }
    
    func bindViewModel() {
        viewModel.didUpdateMovies = { [weak self] (movies) in
            self?.viewModel.movies = movies
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.didUpdateFilteredMovies = { [weak self] (movies) in
            self?.viewModel.filteredMovies = movies
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.didUpdateSearchText = { [weak self] (text) in
            self?.viewModel.searchText = text
            self?.viewModel.filterMoviesBySearchText()
        }
    }
}

private extension MainViewController {
    func setupView() {
        title = "Popular Movies"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        setupToolbar()
        setupSearchBar()
        setupTableView()
    }
    
    func setupToolbar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal.decrease.circle"),
            style: .plain,
            target: self,
            action: nil
        )
        
        self.navigationItem.rightBarButtonItem?.menu = createFilterMenu()
    }
    
    func createFilterMenu() -> UIMenu {
        var actions = [UIAction]()
        Genre.allCases.forEach { genre in
            let isSelected = viewModel.isGenreSelected(genre: genre)
            let action = UIAction(title: genre.name, state: isSelected ? .on : .off) { [weak self] action in
                self?.viewModel.toggleGenreFilter(genre)
                self?.navigationItem.rightBarButtonItem?.menu = self?.createFilterMenu()
            }

            actions.append(action)
        }
        
        return UIMenu(title: "Filter by genre", children: actions)
    }

}
