//
//  MovieService.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

protocol MovieService {
    func getUpcomingMovies(page: Int, completion: @escaping Response<UpcomingMoviesResponse>)
}
