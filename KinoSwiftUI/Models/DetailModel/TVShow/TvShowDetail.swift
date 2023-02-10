// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let show = try? JSONDecoder().decode(Show.self, from: jsonData)

import Foundation

// MARK: - Show
struct TvShowDetail: Codable {
    let summary: String
    
    enum CodingKeys: String, CodingKey {
        case summary
    }
}
