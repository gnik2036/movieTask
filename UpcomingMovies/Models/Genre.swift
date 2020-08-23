//
//  Genre.swift
//  UpcomingMovies
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

import Foundation

struct Genre: Codable {
    typealias Dictionary = [Int: String]
    
    let id: Int
    let name: String
    
    static func getNameBy(id: Int) -> String? {
        return genres[id]
    }
    
    static var genres: Dictionary = [:]
}

extension Genre {
    static func ==(lhs: Genre, rhs: Genre) -> Bool {
        return lhs.id == rhs.id
    }
}
