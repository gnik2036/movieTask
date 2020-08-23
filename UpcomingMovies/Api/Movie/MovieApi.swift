//
//  MovieApi.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

struct MovieApi: MovieService {
    func getUpcomingMovies(page: Int, completion: @escaping Response<UpcomingMoviesResponse>) {
        let request = Request(url: Endpoints.movie.upcoming.value)
        let params: Params = [
            "api_key": MovieApiConfig.key,
            "language": "en-US",
            "page": "\(page)"
        ]
        
        request.get(params: params) { (result: Result<UpcomingMoviesResponse>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .error(let err):
                completion(.error(err))
            }
        }
    }
}
