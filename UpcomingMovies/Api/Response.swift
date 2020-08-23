//
//  Response.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

typealias Response<T: Decodable> = (Result<T>) -> ()
