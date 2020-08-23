//
//  Result.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.
enum Result<T> {
    case success(T)
    case error(ApiError)
}
