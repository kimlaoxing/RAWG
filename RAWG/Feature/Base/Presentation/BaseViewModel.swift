//
//  BaseViewModel.swift
//  RAWG
//
//  Created by Kevin Maulana on 13/09/2022.
//

import Foundation

protocol BaseViewModelOutput {
    func getGameList()
    func getTrailer(with id: String)
}

protocol BaseViewModelInput {
    var gameList: Observable<[GameResponse.GameResult]> { get }
    var state: Observable<BaseViewState> { get }
    var gameTrailer: Observable<[GameTrailer.Result]> { get }
}

protocol BaseViewModel: BaseViewModelOutput, BaseViewModelInput {}

final class DefaultBaseViewModel: BaseViewModel {
    
    let gameList: Observable<[GameResponse.GameResult]> = Observable([])
    let gameTrailer: Observable<[GameTrailer.Result]> = Observable([])
    let state: Observable<BaseViewState> = Observable(.loading)
    private let useCase = BaseUseCase()
    
    init() {
        self.getGameList()
        self.getTrailer(with: "3498")
    }
    
    internal func getGameList() {
        self.state.value = .loading
        useCase.getListGame { data in
            if data.isEmpty {
                self.state.value = .empty
            }
            self.state.value = .normal
            self.gameList.value = data
        }
    }
    
    internal func getTrailer(with id: String) {
        self.state.value = .loading
        useCase.getTrailer(with: id) { data in
            self.state.value = .normal
            self.gameTrailer.value = data
        }
    }
}
