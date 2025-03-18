//
//  MainViewController+TableView.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 11..
//

import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        setupTableViewConstraints()
        registerCells()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = viewModel.filteredMovies[indexPath.row]
        let cellViewModel = MovieCellViewModel(cell: MovieTableCell(from: movie))
        cell.setup(with: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MovieDetails", bundle: nil)
        if let detailsVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
            detailsVC.setMovie(movie: viewModel.filteredMovies[indexPath.row])
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

private extension MainViewController {
    func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])
    }
    
    func registerCells() {
        tableView.register(MovieTableViewCell.register(), forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
}
