//
//  GenreApi.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

struct GenreApi: GenreService {
    func getGenres(completion: @escaping Response<[Genre]>) {
        let request = Request(url: Endpoints.genre.all.value)
        let params: Params = [
            "api_key": MovieApiConfig.key,
            "language": "en-US"
        ]
        
        request.get(params: params) { (result: Result<GenresResponse>) in
            switch result {
            case .success(let response):
                let genres = response.genres ?? []
                genres.forEach({ (genre) in
                    Genre.genres[genre.id] = genre.name
                })
                completion(.success(genres))
            case .error(let err):
                completion(.error(err))
            }
        }
    }
}
