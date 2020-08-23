//
//  ApiError.swift
//  UpcomingMovies
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

struct ApiError: Codable {
    var statusCode: Int?
    var statusMessage: String?
    var success: Bool = false
    
    init(statusMessage: String) {
        self.statusCode = 500
        self.statusMessage = statusMessage
    }
    
    static var defaultModel: ApiError {
        return ApiError(statusMessage: "Unable to connect to the server")
    }
}
