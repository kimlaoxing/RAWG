//
//  BaseRepository.swift
//  RAWG
//
//  Created by Kevin Maulana on 13/09/2022.
//

import Foundation

protocol BaseRepository {
    func getListGame(_ completion: @escaping([GameResponse.GameResult]) -> Void)
    func getGameDetail(with id: String, completion: @escaping(GameDetailResponse) -> Void)
    func getAllFavoriteGame(completion: @escaping(_ members: [FavoriteModel]) -> Void)
    func getFavorite(_ id: Int, completion: @escaping(_ bool: Bool) -> Void)
    func addFavorite(_ favoriteModel: FavoriteModel)
    func deleteFavorite(_ id: Int)
    func getTrailer(with id: String, completion: @escaping([GameTrailer.Result]) -> Void)
}

final class BaseRepositoryData: BaseRepository {
    
    private var remoteData: BaseRemoteData
    private var localData: BaseLocalData
    
    init(
        remoteData: BaseRemoteData = BaseRemoteData(),
        localData: BaseLocalData = BaseLocalData()
    ) {
        self.remoteData = remoteData
        self.localData = localData
    }
    
    func getListGame(_ completion: @escaping ([GameResponse.GameResult]) -> Void) {
        self.remoteData.getListGame { data in
            completion(data)
        }
    }
    
    func getGameDetail(with id: String, completion: @escaping(GameDetailResponse) -> Void) {
        self.remoteData.getDetailGame(with: id) { data in
            completion(data)
        }
    }
    
    func getAllFavoriteGame(completion: @escaping ([FavoriteModel]) -> Void) {
        self.localData.getAllFavoriteGame { members in
            completion(members)
        }
    }
    
    func getFavorite(_ id: Int, completion: @escaping (Bool) -> Void) {
        self.localData.getFavorite(id) { bool in
            completion(bool)
        }
    }
    
    func addFavorite(_ favoriteModel: FavoriteModel) {
        do {
            try self.localData.addFavorite(favoriteModel)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteFavorite(_ id: Int) {
        do {
            try self.localData.deleteFavorite(id)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getTrailer(with id: String, completion: @escaping([GameTrailer.Result]) -> Void) {
        self.remoteData.getTrailer(with: id) { data in
            completion(data)
        }
    }
}
