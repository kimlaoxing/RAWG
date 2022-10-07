//
//  BaseUseCase.swift
//  RAWG
//
//  Created by Kevin Maulana on 13/09/2022.
//

import Foundation

protocol BaseDomain {
    mutating func getListGame(_ completion: @escaping ([GameResponse.GameResult]) -> Void)
    mutating func getTrailer(with id: String, completion: @escaping([GameTrailer.Result]) -> Void)
}

final class BaseUseCase: BaseDomain {
    
    private var repository: BaseRepository
    
    init() {
        self.repository = BaseRepositoryData()
    }
    
    func getListGame(_ completion: @escaping ([GameResponse.GameResult]) -> Void) {
        self.repository.getListGame { data in
            completion(data)
        }
    }
    
    func getTrailer(with id: String, completion: @escaping ([GameTrailer.Result]) -> Void) {
        self.repository.getTrailer(with: id) { data in
            completion(data)
        }
    }
}
