//
//  DetailGameViewModel.swift
//  RAWG
//
//  Created by Kevin Maulana on 23/09/22.
//

import Foundation

protocol DetailGameViewModelInput {
    func getGameDetail(with id: String)
    func addFavorite(_ favoriteModel: FavoriteModel)
    func deleteFavorite(_ id: Int)
    func getFavorite(_ id: Int)
}

protocol DetailGameViewModelOutput {
    var gameDetailResponse: Observable<GameDetailResponse?> { get }
    var state: Observable<BaseViewState> { get }
    var buttonState: Observable<DetailGameButtonMode> { get }
}

protocol DetailGameViewModel: DetailGameViewModelInput, DetailGameViewModelOutput {}

final class DefaultDetailGameViewModel: DetailGameViewModel {
    
    let gameDetailResponse: Observable<GameDetailResponse?> = Observable(nil)
    let state: Observable<BaseViewState> = Observable(.loading)
    let buttonState: Observable<DetailGameButtonMode> = Observable(.isSaved)
    private let useCase = DetailGameUseCase()
    
    init(id: String) {
        getGameDetail(with: id)
        getFavorite(Int(id) ?? 0)
    }
    
    func getGameDetail(with id: String) {
        if id != "" {
            self.useCase.getGameDetail(with: id) { data in
                self.state.value = .normal
                self.gameDetailResponse.value = data
            }
        } else {
            self.state.value = .empty
        }
    }
    
    func addFavorite(_ favoriteModel: FavoriteModel) {
        self.state.value = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.useCase.addFavorite(favoriteModel)
            self.buttonState.value = .isSaved
            self.state.value = .normal
        }
    }
    
    func deleteFavorite(_ id: Int) {
        self.state.value = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.useCase.deleteFavorite(id)
            self.buttonState.value = .notSaved
            self.state.value = .normal
        }
    }
    
    func getFavorite(_ id: Int) {
        self.useCase.getFavorite(id) { bool in
            if bool {
                self.buttonState.value = .isSaved
            } else {
                self.buttonState.value = .notSaved
            }
        }
    }
}
