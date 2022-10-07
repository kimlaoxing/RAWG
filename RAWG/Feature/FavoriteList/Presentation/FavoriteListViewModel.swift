//
//  FavoriteListViewModel.swift
//  RAWG
//
//  Created by Kevin Maulana on 25/09/22.
//

import Foundation

protocol FavoriteListViewModelInput {
    func getListFavorite()
    func deleteGame(with id: Int)
}

protocol FavoriteListViewModelOutput {
    var gameListFavorite: Observable<[FavoriteModel]?> { get }
    var state: Observable<BaseViewState> { get }
}

protocol FavoriteListViewModel: FavoriteListViewModelOutput, FavoriteListViewModelInput {}

final class DefaultFavoriteListViewModel: FavoriteListViewModel {
    
    let gameListFavorite: Observable<[FavoriteModel]?> = Observable(nil)
    let state: Observable<BaseViewState> = Observable(.loading)
    private let useCase = FavoriteListUseCase()
    
    func getListFavorite() {
        self.useCase.getListFavorite { data in
            if data.isEmpty {
                self.state.value = .empty
            } else {
                self.gameListFavorite.value = data
                self.state.value = .normal
            }
        }
    }
    
    func deleteGame(with id: Int) {
        DispatchQueue.main.async {
            self.useCase.deleteGame(with: id)
        }
    }
}
