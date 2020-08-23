//
//  MovieDetailViewController.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties -
    private let movie: Movie
    private let screen = MovieDetailViewControllerScreen()
    
    // MARK: - Init -
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = screen
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        screen.setup(movie: movie)
    }
}

// MARK: - Setup -
private extension MovieDetailViewController {
    func setupNavigationItem() {
        navigationItem.title = movie.title
    }
}
