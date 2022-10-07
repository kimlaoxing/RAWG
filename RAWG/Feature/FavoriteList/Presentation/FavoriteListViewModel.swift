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
    func toDetailGame(with id: String)
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
    private let router: Routes
    
    typealias Routes = DetailGameRoute
    
    init(router: Routes) {
        self.router = router
    }
    
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
    
    func toDetailGame(with id: String) {
        self.router.toDetailGame(id: id)
    }
}
