//
//  DetailGameViewController.swift
//  RAWG
//
//  Created by Kevin Maulana on 23/09/22.
//

import Declayout
import UIKit

final class DetailGameViewController: UIViewController {
    
    var viewModel: DetailGameViewModel?
    private var data: GameDetailResponse?
    private var favoriteModel: FavoriteModel?
    
    private lazy var contentView = DetailGameView()
    
    private lazy var vStack = UIStackView.make {
        $0.axis = .vertical
    }
    
    private lazy var container = UIView.make {
        $0.height(ScreenSize.height * 0.08)
    }
    
    private lazy var addToFavoriteButton = UIButton.make {
        $0.verticalPadding(to: container, Padding.half)
        $0.horizontalPadding(to: container, Padding.reguler)
        $0.layer.cornerRadius = 15
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        subViews()
        
    }
    
    private func bind() {
        viewModel?.gameDetailResponse.observe(on: self) { [weak self] data in
            guard let self = self, let data = data else { return }
            self.data = data
            self.updateContent(with: data)
            self.favoriteModel = FavoriteModel(id: Int32(data.id ?? 0),
                                               name: data.name ?? "",
                                               release: data.released ?? "",
                                               backgroundImage: data.backgroundImage ?? "",
                                               metacritic: Int32(data.metacritic ?? 0),
                                               description: data.description ?? "",
                                               developers: data.developers?.first?.name ?? "",
                                               publishers: data.publishers?.first?.name ?? "",
                                               genres: data.genres?.first?.name ?? "",
                                               website: data.website ?? "")
            self.configureButton(with: data)
        }
        
        viewModel?.state.observe(on: self) { [weak self] state in
            self?.handleState(with: state)
        }
        
        viewModel?.buttonState.observe(on: self) { [weak self] state in
            self?.setButtonMode(with: state)
        }
    }
    
    private func subViews() {
        view.backgroundColor = .white
        view.addSubviews([
            vStack.addArrangedSubviews([
                contentView,
                container.addSubviews([
                    addToFavoriteButton
                ])
            ])
        ])
        layout()
    }
    
    private func updateContent(with data: GameDetailResponse) {
        contentView.setContent(with: data)
        title = "\(data.name ?? "Detail Game")"
    }
    
    private func handleState(with state: BaseViewState) {
        switch state {
        case .loading:
            self.manageLoadingActivity(isLoading: true)
            self.vStack.isHidden = true
        case .normal:
            self.manageLoadingActivity(isLoading: false)
            self.vStack.isHidden = false
        case .empty:
            self.manageLoadingActivity(isLoading: false)
        }
    }
    
    private func configureButton(with data: GameDetailResponse) {
        contentView.toWebsiteSelectCallBack = {
            if let url = URL(string: data.website ?? "") {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc private func saveButton() {
        if let data = self.favoriteModel {
            self.viewModel?.addFavorite(data)
        }
    }
    
    @objc private func deleteButton() {
        if let data = self.favoriteModel {
            self.viewModel?.deleteFavorite(Int(data.id ?? 0))
        }
    }
    
    private func setButtonMode(with mode: DetailGameButtonMode) {
        switch mode {
        case .isSaved:
            addToFavoriteButton.setTitle("Saved", for: .normal)
            addToFavoriteButton.backgroundColor = .black
            addToFavoriteButton.addTarget(self, action: #selector(deleteButton), for: .touchUpInside)
        case .notSaved:
            addToFavoriteButton.setTitle("Save", for: .normal)
            addToFavoriteButton.backgroundColor = .gray
            addToFavoriteButton.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
        }
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: view.topAnchor, constant: Padding.double + safeAreaInset.top + Padding.half),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
