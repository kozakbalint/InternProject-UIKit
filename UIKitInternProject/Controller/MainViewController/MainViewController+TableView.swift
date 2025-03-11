//
//  MainViewController+TableView.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 11..
//

import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.setupTableViewConstraints()
        self.registerCells()
    }
    
    func setupTableViewConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor)
        ])
    }
    
    func registerCells() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewMpdel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewMpdel.movies[indexPath.row].title
        
        return cell
    }
}
