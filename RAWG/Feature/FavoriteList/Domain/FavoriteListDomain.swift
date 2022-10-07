//
//  FavoriteListDomain.swift
//  RAWG
//
//  Created by Kevin Maulana on 25/09/22.
//

import Foundation

protocol FavoriteListDomain {
    mutating func getListFavorite(_ completion: @escaping ([FavoriteModel]) -> Void)
    mutating func deleteGame(with id: Int)
}

final class FavoriteListUseCase: FavoriteListDomain {
    
    private var repository: BaseRepository
    
    init() {
        self.repository = BaseRepositoryData()
    }
    
    func getListFavorite(_ completion: @escaping ([FavoriteModel]) -> Void) {
        self.repository.getAllFavoriteGame { members in
            completion(members)
        }
    }
    
    func deleteGame(with id: Int) {
        self.repository.deleteFavorite(id)
    }
}
