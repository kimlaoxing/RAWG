//
//  DetailGameUseCase.swift
//  RAWG
//
//  Created by Kevin Maulana on 23/09/22.
//

import Foundation

protocol DetailGameDomain {
    mutating func getGameDetail(with id: String, completion: @escaping(GameDetailResponse) -> Void)
    mutating func addFavorite(_ favoriteModel: FavoriteModel)
    mutating func deleteFavorite(_ id: Int)
    mutating func getFavorite(_ id: Int, completion: @escaping(Bool) -> Void)
}

final class DetailGameUseCase: DetailGameDomain {
    
    private var repository: BaseRepository
    
    init() {
        self.repository = BaseRepositoryData()
    }
    
    func getGameDetail(with id: String, completion: @escaping (GameDetailResponse) -> Void) {
        self.repository.getGameDetail(with: id) { data in
            completion(data)
        }
    }
    
    func addFavorite(_ favoriteModel: FavoriteModel) {
        self.repository.addFavorite(favoriteModel)
    }
    
    func deleteFavorite(_ id: Int) {
        self.repository.deleteFavorite(id)
    }
    
    func getFavorite(_ id: Int, completion: @escaping(Bool) -> Void) {
        self.repository.getFavorite(id) { bool in
            completion(bool)
        }
    }
}
