//
//  AppCoordinator.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let upcomingMoviesCoordinator = UpcomingMoviesCoordinator(navigationController: navigationController)
        childCoordinators.append(upcomingMoviesCoordinator)
        upcomingMoviesCoordinator.start()
    }
}
