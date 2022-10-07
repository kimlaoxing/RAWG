//
//  BaseViewController.swift
//  RAWG
//
//  Created by Kevin Maulana on 13/09/2022.
//

import Declayout

final class BaseViewController: UIViewController {
    
    private var gameResult: [GameResponse.GameResult]?
    private var gameTrailers: [GameTrailer.Result]?    
    private var videoEnum: VideoEnum?
    var viewModel: BaseViewModel?
    
    private var verticalCollectionHeight: NSLayoutConstraint? {
        didSet { verticalCollectionHeight?.activated() }
    }
    
    private var caroucellCollectionHeight: NSLayoutConstraint? {
        didSet { caroucellCollectionHeight?.activated() }
    }
    
    private lazy var scrollView = ScrollViewContainer.make {
        $0.edges(to: view)
    }
    
    private lazy var verticalCollection = DefaultCollectionView(frame: .zero)
    private lazy var caroucellCollection = DefaultCollectionView(frame: .zero)
    
    private lazy var emptyView = EmptyDataView.make {
        $0.title.text = "Empty Data"
        $0.button.setTitle("Back", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subViews()
        bind()
        viewModel?.viewDidLoad()
        verticalCollectionConfigure()
        caroucellCollectionConfigure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.videoEnum = .willDisappear
        caroucellCollection.reloads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.videoEnum = .willAppear
        caroucellCollection.reloads()
    }

    private func subViews() {
        title = "Home"
        view.addSubviews([
            scrollView.addArrangedSubViews([
                emptyView,
                caroucellCollection,
                verticalCollection
            ])
        ])
    }
    
    private func verticalCollectionConfigure() {
        verticalCollection.showsVerticalScrollIndicator = false
        verticalCollection.register(GameListHomeCollectionViewCell.self, forCellWithReuseIdentifier: "GameListHomeCollectionViewCell")
        verticalCollection.delegate = self
        verticalCollection.dataSource = self
        verticalCollection.allowsMultipleSelection = false
        verticalCollectionHeight = verticalCollection.heightAnchor.constraint(equalToConstant: 0)
        verticalCollection.isBouncesVertical = true
    }
    
    private func caroucellCollectionConfigure() {
        caroucellCollection.showsHorizontalScrollIndicator = false
        caroucellCollection.register(GameListCarouCell.self, forCellWithReuseIdentifier: "GameListCarouCell")
        caroucellCollection.delegate = self
        caroucellCollection.dataSource = self
        caroucellCollection.allowsMultipleSelection = false
        caroucellCollection.isBouncesVertical = false
        caroucellCollectionHeight = caroucellCollection.heightAnchor.constraint(equalToConstant: ScreenSize.height * 0.3)
        let swLayout = SWInflateLayout()
        caroucellCollection.collectionViewLayout = swLayout
        caroucellCollection.decelerationRate = UIScrollView.DecelerationRate.fast
        swLayout.scrollDirection = .horizontal
    }
    
    private func bind() {
        viewModel?.gameList.observe(on: self) { [weak self] data in
            guard let self = self else { return }
            self.gameResult = data
            self.verticalCollection.reloadData()
            self.updateCollectionViewHeights()
        }
        
        viewModel?.state.observe(on: self) { [weak self] data in
            guard let self = self else { return }
            self.handleState(with: data)
        }
        
        viewModel?.gameTrailer.observe(on: self) { [weak self] data in
            guard let self = self else { return }
            self.gameTrailers = data
            self.caroucellCollection.reloadData()
        }
    }
    
    private func handleState(with state: BaseViewState) {
        switch state {
        case .loading:
            emptyView.isHidden = true
            self.manageLoadingActivity(isLoading: true)
        case .normal:
            emptyView.isHidden = true
            self.manageLoadingActivity(isLoading: false)
        case .empty:
            emptyView.isHidden = false
            self.manageLoadingActivity(isLoading: false)
        }
    }
    
    private func goToDetailGame(with indexPath: IndexPath) {
        let id = "\(self.gameResult?[indexPath.row].id ?? 0)"
        viewModel?.goToDetail(id: id)
    }
    
    private func updateCollectionViewHeights() {
        self.verticalCollectionHeight?.constant = self.verticalCollection.layoutContentSizeHeight
        self.view.layoutIfNeeded()
    }
    
    private func checkVisibilityOfCell(cell: GameListCarouCell, indexPath: IndexPath) {
        if let cellRect = (caroucellCollection.layoutAttributesForItem(at: indexPath)?.frame) {
            let completelyVisible = caroucellCollection.bounds.contains(cellRect)
            if completelyVisible {
                cell.playVideo()
            } else {
                cell.stopVideo()
            }
        }
    }
}

extension BaseViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleCells = self.caroucellCollection.indexPathsForVisibleItems
            .sorted { top, bottom -> Bool in
                return top.section < bottom.section || top.row < bottom.row
            }.compactMap { indexPath -> UICollectionViewCell? in
                return self.caroucellCollection.cellForItem(at: indexPath)
            }
        let indexPaths = self.caroucellCollection.indexPathsForVisibleItems.sorted()
        let cellCount = visibleCells.count
        guard let firstCell = visibleCells.first as? GameListCarouCell, let firstIndex = indexPaths.first else { return }
        checkVisibilityOfCell(cell: firstCell, indexPath: firstIndex)
        if cellCount == 1 { return }
        guard let lastCell = visibleCells.last as? GameListCarouCell, let lastIndex = indexPaths.last else { return }
        checkVisibilityOfCell(cell: lastCell, indexPath: lastIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case caroucellCollection:
            let count = self.gameTrailers?.count ?? 0
            if count >= 5 {
                return 5
            } else {
                return count
            }
        case verticalCollection:
            return self.gameResult?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case caroucellCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameListCarouCell",
                                                          for: indexPath) as! GameListCarouCell
            if let data = self.gameTrailers {
                cell.setContent(with: data[indexPath.row])
                if let cellRect = (collectionView.layoutAttributesForItem(at: indexPath)?.frame) {
                    let completelyVisible = collectionView.bounds.contains(cellRect)
                    if completelyVisible {
                        switch self.videoEnum {
                        case .willAppear:
                            cell.playVideo()
                        case .willDisappear:
                            cell.stopVideo()
                        case .none:
                            break
                        }
                    }
                }
            }
            
            return cell
        case verticalCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameListHomeCollectionViewCell",
                                                          for: indexPath) as! GameListHomeCollectionViewCell
            if let data = self.gameResult {
                cell.setContent(with: data[indexPath.row])
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case caroucellCollection:
            return UICollectionViewOneItemPerWidth()
        case verticalCollection:
            return UICollectionViewTwoItemPerWidth()
        default:
            return CGSize()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case caroucellCollection:
            return UIEdgeInsets(top: Padding.double, left: 0, bottom: Padding.double, right: 0)
        case verticalCollection:
            return UIEdgeInsets(top: Padding.double, left: Padding.double, bottom: Padding.double, right: Padding.double)
        default:
            return UIEdgeInsets()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.goToDetailGame(with: indexPath)
    }
}
