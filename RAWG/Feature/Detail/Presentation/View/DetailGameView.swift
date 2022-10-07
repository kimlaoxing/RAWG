//
//  DetailGameView.swift
//  RAWG
//
//  Created by Kevin Maulana on 26/09/22.
//

import Declayout
import UIKit

final class DetailGameView: UIView {
    
    var toWebsiteSelectCallBack: (() -> Void)?
    
    private lazy var scrollView = ScrollViewContainer.make {
        $0.edges(to: self, Padding.reguler)
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var header = UIView.make {
        $0.width(ScreenSize.width)
        $0.height(ScreenSize.height * 0.3)
    }
    
    private lazy var vStack = UIStackView.make {
        $0.axis = .vertical
        $0.spacing = Padding.reguler
        $0.verticalPadding(to: scrollView, Padding.reguler)
    }
    
    private lazy var backgroundImage = UIImageView.make {
        $0.clipsToBounds = true
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 15
        $0.edges(to: header)
    }
    
    private lazy var hStack = UIStackView.make {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    private lazy var releasedDateStack = UIStackView.make {
        $0.axis = .vertical
        $0.spacing = Padding.half
    }
    
    private lazy var websiteStack = UIStackView.make {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(goToWebsite))
        $0.axis = .vertical
        $0.spacing = Padding.half
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(gesture)
    }
    
    private lazy var developerStack = UIStackView.make {
        $0.axis = .vertical
        $0.spacing = Padding.half
    }
    
    private lazy var publisherStack = UIStackView.make {
        $0.axis = .vertical
        $0.spacing = Padding.half
    }
    
    private lazy var favoriteStack = UIStackView.make {
        $0.axis = .horizontal
        $0.spacing = Padding.half
    }
    
    private lazy var releaseTitle = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private lazy var releaseValue = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private lazy var websiteTitle = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private lazy var websiteValue = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private lazy var developerTitle = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private lazy var developerValue = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private lazy var favoriteIcon = UIImageView.make {
        $0.clipsToBounds = true
        $0.image = UIImage(systemName: "star.fill")
        $0.tintColor = .black
        $0.width(10)
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var favoriteValue = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .right
        $0.numberOfLines = 1
    }
    
    private lazy var descriptionTitle = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private lazy var decriptionValue = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .justified
        $0.numberOfLines = 0
    }
    
    private lazy var publisherTitle = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    private lazy var publisherValue = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .justified
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureSubviews() {
        backgroundColor = .clear
        addSubviews([
            scrollView.addArrangedSubViews([
                vStack.addArrangedSubviews([
                    header.addSubviews([
                        backgroundImage
                    ]),
                    hStack.addArrangedSubviews([
                        releasedDateStack.addArrangedSubviews([
                            releaseTitle,
                            releaseValue
                        ]),
                        favoriteStack.addArrangedSubviews([
                            favoriteIcon,
                            favoriteValue
                        ])
                    ]),
                    descriptionTitle,
                    decriptionValue,
                    websiteStack.addArrangedSubviews([
                        websiteTitle,
                        websiteValue
                    ]),
                    developerStack.addArrangedSubviews([
                        developerTitle,
                        developerValue
                    ]),
                    publisherStack.addArrangedSubviews([
                        publisherTitle,
                        publisherValue
                    ])
                ])
            ])
        ])
    }
    
    @objc private func goToWebsite() {
        self.toWebsiteSelectCallBack?()
    }
    
    func setContent(with data: GameDetailResponse) {
        backgroundImage.downloaded(from: data.backgroundImage ?? "")
        releaseValue.text = data.released ?? ""
        releaseTitle.text = "Realesed Date:"
        favoriteValue.text = "\(data.metacritic ?? 0)"
        descriptionTitle.text = "Description:"
        decriptionValue.text = data.description ?? ""
        websiteTitle.text = "Website:"
        websiteValue.text = data.website ?? ""
        developerTitle.text = "Developer:"
        developerValue.text = data.developers?.first?.name
        publisherTitle.text = "Publisher:"
        publisherValue.text = data.publishers?.first?.name
    }
}
