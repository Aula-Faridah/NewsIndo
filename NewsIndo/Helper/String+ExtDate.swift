//
//  String+ExtDate.swift
//  NewsIndo
//
//  Created by MacBook Pro on 23/04/24.
//

import Foundation

extension String {
    func relativeToCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "id_ID")
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        //        butuh string dari Date
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        let calender = Calendar.current
        
        let interval = calender.dateComponents([.year, .month, .weekOfMonth, .day, .hour, .minute], from: date, to: Date())
        
        //logic
        if let year = interval.year, year > 0 {
            dateFormatter.dateFormat = "dd MMMM yyyy"
            return dateFormatter.string(from: date)
        } else if let month = interval.month, month > 1 {
            dateFormatter.dateFormat = "dd MMMM yyyy"
            return dateFormatter.string(from: date)
        } else if let month = interval.month, month == 1 {
            return "\(month) bulan yang lalu"
        } else if let week = interval.weekOfMonth, week > 0 {
            return "\(week) minggu yang lalu"
        } else if let day = interval.day, day > 0 {
            return "\(day) hari yang lalu"
        } else if let hour = interval.hour, hour > 0 {
            return "\(hour) jam yang lalu"
        } else if let minute = interval.minute, minute > 0 {
            return "\(minute) menit yang lalu"
        } else {
            return "Baru saja"
        }
    }
}
