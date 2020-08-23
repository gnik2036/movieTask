//
//  MovieImageURL.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

struct MovieImageURL {
    let path: String
    
    var poster: String {
        return "https://image.tmdb.org/t/p/w300\(path)"
    }
    
    var backdrop: String {
        return "https://image.tmdb.org/t/p/w780\(path)"
    }
}

