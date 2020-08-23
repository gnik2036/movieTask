//
//  UpcomingMoviesCoordinator.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

import UIKit

protocol UpcomingMoviesCoordinatorDelegate: AnyObject {
    func goToMovieDetail(movie: Movie)
}

final class UpcomingMoviesCoordinator: Coordinator {
    // MARK - Properties -
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    // MARK: - Init -
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = UpcomingMoviesViewController(coordinator: self)
        navigationController.pushViewController(viewController, animated: false)
    }
}

// MARK: - UpcomingMoviesCoordinatorDelegate -
extension UpcomingMoviesCoordinator: UpcomingMoviesCoordinatorDelegate {
    func goToMovieDetail(movie: Movie) {
        let viewController = MovieDetailViewController(movie: movie)
        navigationController.pushViewController(viewController, animated: true)
    }
}
