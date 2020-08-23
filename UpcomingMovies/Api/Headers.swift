//
//  Headers.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.
final class Headers {
    private(set) var values: Params = [:]
    
    func update(_ value: String, forKey key: String) {
        values.updateValue(value, forKey: key)
    }
}

