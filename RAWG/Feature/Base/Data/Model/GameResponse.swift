//
//  GameResponse.swift
//  RAWG
//
//  Created by Kevin Maulana on 14/09/2022.
//

import Foundation

struct GameResponse: Codable {
    let count: Int
    let next: String
    let results: [GameResult]?
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case results
    }
    
    struct GameResult: Codable {
        let id: Int?
        let name: String?
        let released: String?
        let backgroundImage: String?
        let metacritic: Int?
        let genres: [Genre]?
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case released
            case backgroundImage = "background_image"
            case metacritic
            case genres
        }
        
        struct Genre: Codable {
            let id: Int?
            let name, slug: String?
            let gamesCount: Int?
            let imageBackground: String?
            
            enum CodingKeys: String, CodingKey {
                case id, name, slug
                case gamesCount = "games_count"
                case imageBackground = "image_background"
            }
        }
    }
}
