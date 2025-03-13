//
//  MainViewController.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 11..
//

import Combine
import UIKit

class MainViewController: UIViewController {
    var viewModel = MainViewModel()
    var cellViewModels = [MovieCellViewModel]()
    var searchController = UISearchController()
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
        
        setupToolbar()
        setupSearchBar()
        setupTableView()
    }
    
    func bindViewModel() {
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                self?.cellViewModels = movies.map { movie in
                    MovieCellViewModel(cell: MovieTableCell(from: movie))
                }
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$filteredMovies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.viewModel.filterMoviesBySearchText()
            }
            .store(in: &cancellables)
        
        viewModel.$genreFilters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.viewModel.filterMoviesByGenre()
            }
            .store(in: &cancellables)
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
        for genre in Genre.allCases {
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
