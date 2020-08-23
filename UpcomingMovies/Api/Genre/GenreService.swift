//
//  GenreService.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

protocol GenreService {
    func getGenres(completion: @escaping Response<[Genre]>)
}
