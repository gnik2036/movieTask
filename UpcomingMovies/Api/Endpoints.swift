//
//  Endpoints.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.
private protocol Endpoint {
    var endpoint: String { get }
    var value: String { get }
}

enum Endpoints {
    private static var version: Int = 3
    private static var baseUrl: String { return "\(MovieApiConfig.baseUrl)/\(Endpoints.version)" }
    
    enum movie: Endpoint {
        var endpoint: String { return "movie" }
        case upcoming
        
        var value: String {
            switch self {
            case .upcoming: return "\(Endpoints.baseUrl)/discover/\(endpoint)"
            }
        }
    }
    
    enum genre: Endpoint {
        var endpoint: String { return "genre" }
        case all
        
        var value: String {
            switch self {
            case .all: return "\(Endpoints.baseUrl)/\(endpoint)/movie/list"
            }
        }
    }
}
