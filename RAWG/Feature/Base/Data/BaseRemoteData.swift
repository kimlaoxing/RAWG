//
//  BaseRemoteData.swift
//  RAWG
//
//  Created by Kevin Maulana on 13/09/2022.
//

import Foundation
import Alamofire

protocol BaseRemote {
    mutating func getListGame(_ completion: @escaping([GameResponse.GameResult]) -> Void)
    mutating func getDetailGame(with id: String, completion: @escaping(GameDetailResponse) -> Void)
    mutating func getTrailer(with id: String, completion: @escaping([GameTrailer.Result]) -> Void)
}

struct BaseRemoteData: BaseRemote {
    
    mutating func getListGame(_ completion: @escaping([GameResponse.GameResult]) -> Void) {
        AF.request("\(Endpoint.baseURL)games?key=\(Endpoint.apiKey)",
                   method: .get,
                   encoding: JSONEncoding.default
        )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: GameResponse.self, completionHandler: { data in
                switch data.result {
                case .success(let data):
                    if let data = data.results {
                        completion(data)
                    }
                case .failure:
                    break
                }
            })
    }
    
    mutating func getDetailGame(with id: String, completion: @escaping (GameDetailResponse) -> Void) {
        print("id is \(id)")
        AF.request("\(Endpoint.baseURL)games/\(id)?key=\(Endpoint.apiKey)",
                   method: .get,
                   encoding: JSONEncoding.default
        )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: GameDetailResponse.self) { data in
                switch data.result {
                case .success(let data):
                    completion(data)
                case .failure:
                    break
                }
            }
    }
    
    mutating func getTrailer(with id: String, completion: @escaping([GameTrailer.Result]) -> Void) {
        AF.request("\(Endpoint.baseURL)games/\(id)/movies?key=\(Endpoint.apiKey)",
                   method: .get,
                   encoding: JSONEncoding.default
        )
            .validate(statusCode: 200..<300)
            .responseDecodable(of: GameTrailer.self) { data in
                switch data.result {
                case .success(let data):
                    if let data = data.results {
                        completion(data)
                    }
                case .failure:
                    break
                }
            }
    }
}
