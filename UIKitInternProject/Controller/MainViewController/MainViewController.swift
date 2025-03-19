//
//  MainViewController.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 11..
//

import UIKit

final class MainViewController: UIViewController {
    var viewModel = MainViewModel()
    var cellViewModels = [MovieCellViewModel]()
    var searchController = UISearchController()
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.mainViewModelDelegate = self
        viewModel.fetchMovies()
        setupView()
    }
}

extension MainViewController: MainViewModelDelegate {
    func didUpdateMovies(_ movies: [Movie]) {
        cellViewModels = movies.map {
            MovieCellViewModel(cell: MovieTableCell(from: $0))
        }
        viewModel.movies = movies
        viewModel.filteredMovies = movies
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func didUpdateFilteredMovies(_ filteredMovies: [Movie]) {
        viewModel.filteredMovies = filteredMovies
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func didUpdateSearchText(_ searchText: String) {
        viewModel.searchText = searchText
        viewModel.filterMoviesBySearchText()
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
