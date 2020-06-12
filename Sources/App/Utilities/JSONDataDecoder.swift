//
//  DateDecoder.swift
//  
//
//  Created by Max Baumbach on 12/06/2020.
//

import Foundation

struct DateDecoder {

    static func decodeDate(using formatter: ISO8601DateFormatter) -> JSONDecoder.DateDecodingStrategy {

        .custom { decoder -> Date in
            formatter.formatOptions = [.withInternetDateTime,
                                       .withDashSeparatorInDate,
                                       .withColonSeparatorInTime]

            let container = try decoder.singleValueContainer()

            let dateString = try container.decode(String.self)

            if let date = formatter.date(from: dateString) {
                return date
            }

            return Date(timeIntervalSinceReferenceDate: 0)
        }
    }

}
