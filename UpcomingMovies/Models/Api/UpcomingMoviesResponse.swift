//
//  UpcomingMoviesResponse.swift
//  UpcomingMovies
///  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

struct UpcomingMoviesResponse: Codable {
    var results: [Movie]?
    var page: Int?
    var totalResults: Int?
    var dates: Dates?
    var totalPages: Int?
}

