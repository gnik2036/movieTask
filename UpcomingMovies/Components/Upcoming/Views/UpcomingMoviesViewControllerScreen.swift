//
//  UpcomingMoviesViewControllerScreen.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.
import UIKit

final class UpcomingMoviesViewControllerScreen: UIView {
    
    // MARK: - Properties -
    private unowned let errorViewDelegate: UpcomingMoviesErrorViewDelegate
    
    // MARK: - Views -
    let tableView: UITableView = {
        let tv = UITableView()
        tv.keyboardDismissMode = .interactive
        tv.backgroundColor = .white
        tv.tableHeaderView = UIView()
        tv.tableFooterView = UIView()
        return tv
    }()
    private(set) lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.dimsBackgroundDuringPresentation = false
        sc.hidesNavigationBarDuringPresentation = true
        return sc
    }()
    private let emptyView = UpcomingMoviesEmptyView()
    private let errorView = UpcomingMoviesErrorView()
    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .white)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.hidesWhenStopped = true
        ai.color = .black
        return ai
    }()
    
    // MARK: - Init -
    init(errorViewDelegate: UpcomingMoviesErrorViewDelegate) {
        self.errorViewDelegate = errorViewDelegate
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public functions -
    func changeUI(for state: UpcomingMoviesViewState) {
        tableView.reloadData()
        switch state {
        case .loading:
            emptyView.isHidden = true
            errorView.isHidden = true
            activityIndicator.startAnimating()
            tableView.isHidden = true
            searchController.searchBar.isHidden = true
        case .loadingMore:
            emptyView.isHidden = true
            errorView.isHidden = true
            activityIndicator.stopAnimating()
            tableView.isHidden = false
            searchController.searchBar.isHidden = false
        case .finished:
            emptyView.isHidden = true
            errorView.isHidden = true
            activityIndicator.stopAnimating()
            tableView.isHidden = false
            searchController.searchBar.isHidden = false
        case .filtering:
            emptyView.isHidden = true
            errorView.isHidden = true
            activityIndicator.stopAnimating()
            tableView.isHidden = false
            searchController.searchBar.isHidden = false
        case .empty(let text):
            emptyView.update(searchText: text)
            
            emptyView.isHidden = false
            errorView.isHidden = true
            activityIndicator.stopAnimating()
            tableView.isHidden = true
            searchController.searchBar.isHidden = false
        case .error(let err):
            errorView.setError(text: err.statusMessage)
            
            emptyView.isHidden = true
            errorView.isHidden = false
            activityIndicator.stopAnimating()
            tableView.isHidden = true
            searchController.searchBar.isHidden = true
        case .errorLoadingMore:
            emptyView.isHidden = true
            errorView.isHidden = true
            activityIndicator.stopAnimating()
            tableView.isHidden = false
            searchController.searchBar.isHidden = false
        }
    }
}

// MARK: - CodeView -
extension UpcomingMoviesViewControllerScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(emptyView)
        addSubview(errorView)
        addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        tableView.fillSuperview()
        
        emptyView.anchorCenterSuperview()
        emptyView.anchor(height: UpcomingMoviesEmptyView.size.height, width: UpcomingMoviesEmptyView.size.width)
        
        errorView.anchorCenterSuperview()
        errorView.anchor(height: UpcomingMoviesErrorView.size.height, width: UpcomingMoviesErrorView.size.width)
        
        activityIndicator.anchorCenterSuperview()
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        errorView.delegate = errorViewDelegate
        changeUI(for: .loading)
    }
}
