//
//  GameTrailer.swift
//  RAWG
//
//  Created by Kevin Maulana on 06/10/22.
//

import Foundation

public struct GameTrailer: Codable {
    public let results: [Result]?

    public init(results: [Result]?) {
        self.results = results
    }
    
    public struct Result: Codable {
        public let id: Int?
        public let name: String?
        public let preview: String?
        public let data: DataClass?

        public init(id: Int?, name: String?, preview: String?, data: DataClass?) {
            self.id = id
            self.name = name
            self.preview = preview
            self.data = data
        }
        
        public struct DataClass: Codable {
            public let the480: String?
            public let max: String?

            enum CodingKeys: String, CodingKey {
                case the480 = "480"
                case max = "max"
            }

            public init(the480: String?, max: String?) {
                self.the480 = the480
                self.max = max
            }
        }
    }
}
