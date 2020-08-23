//
//  UpcomingMoviesDataSource.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

import UIKit

protocol UpcomingMoviesDataSourceInfiniteScrollDelegate: AnyObject {
    func upcomingMoviesDataSourceInfiniteScrollDelegateOnExecute()
}

final class UpcomingMoviesDataSource: NSObject {
    // MARK: - Properties -
    private let movies: [Movie]
    private unowned let infiniteScrollDelegate: UpcomingMoviesDataSourceInfiniteScrollDelegate
    
    // MARK: - Init -
    init(tableView: UITableView,
         infiniteScrollDelegate: UpcomingMoviesDataSourceInfiniteScrollDelegate,
         movies: [Movie]) {
        self.infiniteScrollDelegate = infiniteScrollDelegate
        self.movies = movies
        super.init()
        register(tableView: tableView)
    }
    
    // MARK: - Setup -
    private func register(tableView: UITableView) {
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.estimatedRowHeight = MovieTableViewCell.height
        tableView.rowHeight = MovieTableViewCell.height
    }
}

// MARK: - UITableViewDataSource -
extension UpcomingMoviesDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        cell.setup(movie: movie)

        let isAlmostOnBottom = indexPath.row == (movies.count - 2)
        if isAlmostOnBottom {
            infiniteScrollDelegate.upcomingMoviesDataSourceInfiniteScrollDelegateOnExecute()
        }
        return cell
    }
}
