//
//  DateHelper.swift
//  UpcomingMovies
//
//  Created by mohammed hassan on 8/23/20.
//  Copyright © 2020 mohammedHassan. All rights reserved.

import Foundation

enum DateHelper {
    static func formatFromApi(_ string: String?) -> Date? {
        if let string = string {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-DD"
            return dateFormatter.date(from: string)
        }
        return nil
    }
    
    static func getYearFrom(date: Date?) -> String? {
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY"
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
