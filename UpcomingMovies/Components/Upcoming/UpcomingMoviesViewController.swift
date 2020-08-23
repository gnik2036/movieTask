//
//  UpcomingMoviesViewController.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

import UIKit

final class UpcomingMoviesViewController: UIViewController {
    
    // MARK: - Properties -
    unowned let coordinator: UpcomingMoviesCoordinatorDelegate
    private let movieApi: MovieService
    private let genreApi: GenreService
    private lazy var screen = UpcomingMoviesViewControllerScreen(errorViewDelegate: self)
    private lazy var dataSource = UpcomingMoviesDataSource(tableView: screen.tableView,
                                                           infiniteScrollDelegate: self,
                                                           movies: movies)
    private var state: UpcomingMoviesViewState = .loading {
        didSet {
            screen.changeUI(for: state)
        }
    }
    
    private var total: Int = 0
    private var page: Int = 1
    private var movies: [Movie] = [] {
        didSet {
            self.movies = self.movies.sorted(by: { (Obj1, Obj2) -> Bool in
                          let Obj1_Name = Obj1.title ?? ""
                          let Obj2_Name = Obj2.title ?? ""
                          return (Obj1_Name.localizedCaseInsensitiveCompare(Obj2_Name) == .orderedAscending)
                       })
            dataSource = UpcomingMoviesDataSource(tableView: screen.tableView,
                                                  infiniteScrollDelegate: self,
                                                  movies: movies)
            screen.tableView.dataSource = dataSource
        }
    }
    private var filteredMovies: [Movie] = [] {
        didSet {
            dataSource = UpcomingMoviesDataSource(tableView: screen.tableView,
                                                  infiniteScrollDelegate: self,
                                                  movies: filteredMovies)
            screen.tableView.dataSource = dataSource
        }
    }
    private var isNotEmpty: Bool {
        return total > 0
    }
    private var canInfiniteScroll: Bool {
        guard !movies.isEmpty, isNotEmpty, movies.count < total, !isFiltering() else {
            return false
        }
        switch state {
        case .finished, .errorLoadingMore:
            return true
        default:
            return false
        }
    }
    
    // MARK: - Init -
    init(coordinator: UpcomingMoviesCoordinatorDelegate,
         movieApi: MovieService = MovieApi(),
         genreApi: GenreService = GenreApi()) {
        self.coordinator = coordinator
        self.movieApi = movieApi
        self.genreApi = genreApi
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle -
    override func loadView() {
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupTableView()
        setupSearchController()
        getGenres()
    }
}

// MARK: - Setup -
private extension UpcomingMoviesViewController {
    func setupNavigationItem() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.title = "list of Movies"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.searchController = screen.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupTableView() {
        screen.tableView.dataSource = dataSource
        screen.tableView.delegate = self
        screen.tableView.reloadData()
    }
    
    func setupSearchController() {
        definesPresentationContext = true
        screen.searchController.searchResultsUpdater = self
        screen.searchController.delegate = self
    }
}

// MARK: - Helpers -
private extension UpcomingMoviesViewController {
    func getMovieFor(indexPath: IndexPath) -> Movie {
        let movie: Movie
        if isFiltering() {
            movie = filteredMovies[indexPath.item]
        } else {
            movie = movies[indexPath.item]
        }
        return movie
    }
    
    func getNextPage() {
        let nextPage = page + 1
        getMovies(page: nextPage)
    }
    
    func tryAgain() {
        getNextPage()
    }
}

// MARK: - Api -
private extension UpcomingMoviesViewController {
    func getGenres() {
        genreApi.getGenres { [weak self] (genresResult) in
            guard let self = self else { return }
            
            switch genresResult {
            case .success:
                self.getMovies(page: self.page)
            case .error(let err):
                self.state = .error(err)
            }
        }
    }
    
    func getMovies(page: Int) {
        if isNotEmpty {
            if state == .loading || state == .loadingMore {
                return
            }
        }
        if isFiltering() {
            return
        }
        if isNotEmpty {
            state = .loadingMore
        } else {
            state = .loading
        }
        print("GETTING PAGE -> \(page)")
        movieApi.getUpcomingMovies(page: page) { [weak self] moviesResult in
            guard let self = self else { return }
            
            switch moviesResult {
            case .success(let response):
                if let results = response.results {
                    self.movies.append(contentsOf: results)
                    if results.isEmpty {
                        self.state = .empty("No movies found")
                    } else {
                        if let totalResults = response.totalResults {
                            self.total = totalResults
                        }
                        if let page = response.page {
                            self.page = page
                        }
                        self.state = .finished
                    }
                } else {
                    self.state = .empty("No movies found")
                }
            case .error(let err):
                if self.isNotEmpty {
                    self.state = .errorLoadingMore
                } else {
                    self.state = .error(err)
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate -
extension UpcomingMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = getMovieFor(indexPath: indexPath)
        coordinator.goToMovieDetail(movie: movie)
    }
}

// MARK: - UISearchResultsUpdating -
extension UpcomingMoviesViewController: UISearchResultsUpdating {
    func searchBarIsEmpty() -> Bool {
        return screen.searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredMovies = movies.compactMap { movie in
            guard let title = movie.title,
                title.localizedLowercase.contains(searchText.localizedLowercase) else {
                    return nil
            }
            return movie
        }
        if filteredMovies.isEmpty {
            if searchBarIsEmpty() {
                filteredMovies = movies
                state = .filtering
            } else {
                state = .empty(searchText)
            }
        } else {
            state = .filtering
        }
    }
    
    func isFiltering() -> Bool {
        return screen.searchController.isActive && !searchBarIsEmpty()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive {
            filterContentForSearchText(searchController.searchBar.text ?? "")
        }
    }
}

// MARK: - UISearchControllerDelegate -
extension UpcomingMoviesViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        filteredMovies = movies
        state = .filtering
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        dataSource = UpcomingMoviesDataSource(tableView: screen.tableView,
                                              infiniteScrollDelegate: self,
                                              movies: movies)
        screen.tableView.dataSource = dataSource
        state = .finished
    }
}

// MARK: - UpcomingMoviesErrorViewDelegate -
extension UpcomingMoviesViewController: UpcomingMoviesErrorViewDelegate {
    func upcomingMoviesErrorViewDidTapButton() {
        if Genre.genres.isEmpty {
            getGenres()
        } else {
            getMovies(page: page)
        }
        
    }
}

// MARK: - UpcomingMoviesDataSourceInfiniteScrollDelegate -
extension UpcomingMoviesViewController: UpcomingMoviesDataSourceInfiniteScrollDelegate {
    func upcomingMoviesDataSourceInfiniteScrollDelegateOnExecute() {
        if canInfiniteScroll {
            getNextPage()
        }
    }
}
