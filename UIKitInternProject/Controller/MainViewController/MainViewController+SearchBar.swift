//
//  MainViewController+SearchBar.swift
//  UIKitInternProject
//
//  Created by Balint Kozak on 2025. 03. 11..
//

import UIKit

extension MainViewController: UISearchResultsUpdating {
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchText = searchController.searchBar.text ?? ""
    }
}
