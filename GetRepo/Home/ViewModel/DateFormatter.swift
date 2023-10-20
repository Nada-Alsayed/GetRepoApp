//
//  DateFormatter.swift
//  GetRepo
//
//  Created by MAC on 20/10/2023.
//

import Foundation

class Date_Formatter{
   static func formatDate(_ dateString: String) -> String {
       let dateFormatter = ISO8601DateFormatter()
       if let date = dateFormatter.date(from: dateString) {
           let sixMonthsAgo = Calendar.current.date(byAdding: .month, value: -6, to: Date())!
           
           let outputDateFormatter = DateFormatter()
           outputDateFormatter.dateFormat = "EEEE, MMM dd, yyyy"
           let outputDateString = outputDateFormatter.string(from: date)
           
           if date < sixMonthsAgo {
               return outputDateString
           } else {
               let components = Calendar.current.dateComponents([.month], from: date, to: Date())
               
               if let monthsAgo = components.month, monthsAgo > 0 {
                   return "\(monthsAgo) month\(monthsAgo == 1 ? "" : "s") ago"
               } else {
                   return "Today"
               }
           }
       }
       
       return "Invalid Date"
   }
}
