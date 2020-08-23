//
//  Movie.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.
import Foundation

struct Movie: Codable {
    static var mock: Movie {
        var movie = Movie()
        movie.title = "Alita: Battle Angel"
        movie.posterPath = "/xRWht48C2V8XNfzvPehyClOvDni.jpg"
        movie.popularity = 224.941
        movie.video = false
        movie.id = 399579
        movie.voteCount = 88
        movie.genreIds = [28, 878, 53, 10749]
        movie.backdropPath = "/8RKBHHRqOMOLh5qW3sS6TSFTd8h.jpg"
        movie.overview = "When Alita awakens with no memory of who she is in a future world she does not recognize, she is taken in by Ido, a compassionate doctor who realizes that somewhere in this abandoned cyborg shell is the heart and soul of a young woman with an extraordinary past."
        movie.releaseDate = "2019-01-31"
        movie.adult = false
        return movie
    }
    
    var posterPath: String?
    var adult: Bool?
    var overview: String?
    var releaseDate: String?
    var genreIds: [Int]?
    var id: Int?
    var originalTitle: String?
    var originalLanguage: String?
    var title: String?
    var backdropPath: String?
    var popularity: Float?
    var voteCount: Int?
    var video: Bool?
    var voteAverage: Float?
    
    var formattedReleaseDate: Date? {
        return DateHelper.formatFromApi(releaseDate)
    }
    
    var releaseYear: String? {
        return DateHelper.getYearFrom(date: formattedReleaseDate)
    }
    
    var posterUrlString: String? {
        if let posterPath = posterPath {
            return MovieImageURL(path: posterPath).poster
        }
        return nil
    }
    
    var backdropUrlString: String? {
        if let backdropPath = backdropPath {
            return MovieImageURL(path: backdropPath).backdrop
        }
        return nil
    }
}

extension Movie {
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}
