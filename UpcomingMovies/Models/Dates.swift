//
//  Dates.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

import Foundation

struct Dates: Codable {
    var maximum: String?
    var minimum: String?
    
    var formattedMaximum: Date? {
        return DateHelper.formatFromApi(maximum)
    }
    
    var maximumYear: String? {
        return DateHelper.getYearFrom(date: formattedMaximum)
    }
    
    var formattedMinimum: Date? {
        return DateHelper.formatFromApi(minimum)
    }
    
    var minimumYear: String? {
        return DateHelper.getYearFrom(date: formattedMinimum)
    }
}
