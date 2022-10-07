//
//  FavoriteTableViewCell.swift
//  RAWG
//
//  Created by Kevin Maulana on 25/09/22.
//

import Declayout

final class FavoriteTableViewCell: UITableViewCell {
    
    private lazy var containerView = UIStackView.make {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.horizontalPadding(to: contentView, Padding.double)
        $0.verticalPadding(to: contentView, Padding.reguler)
    }
    
    private lazy var hStack = UIStackView.make {
        $0.axis = .horizontal
        $0.spacing = Padding.half
    }
    
    private lazy var backgroundImage = UIImageView.make {
        $0.clipsToBounds = true
        $0.makeRounded()
        $0.contentMode = .scaleAspectFit
        $0.dimension(40)
    }
    
    private lazy var title = UILabel.make {
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textAlignment = .left
    }
    
    private lazy var descriptionLabel = UILabel.make {
        $0.numberOfLines = 2
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .left
    }
    
    private lazy var ratingStack = UIStackView.make {
        $0.axis = .vertical
    }
    
    private lazy var labelStack = UIStackView.make {
        $0.axis = .vertical
    }
    
    private lazy var ratinImage = UIImageView.make {
        $0.clipsToBounds = true
        $0.tintColor = .black
        $0.contentMode = .scaleAspectFit
        $0.height(10)
    }
    
    private lazy var ratingLabel = UILabel.make {
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textAlignment = .center
    }
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        subViews()
    }
    
    required init?(coder Decoder: NSCoder) {
        super.init(coder: Decoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subViews() {
        contentView.addSubviews([
            containerView.addArrangedSubviews([
                hStack.addArrangedSubviews([
                    backgroundImage,
                    labelStack.addArrangedSubviews([
                        title,
                        descriptionLabel
                    ])
                ]),
                ratingStack.addArrangedSubviews([
                    ratinImage,
                    ratingLabel
                ])
            ])
        ])
    }
    
    func setContent(with data: FavoriteModel) {
        self.title.text = data.name ?? ""
        self.backgroundImage.downloaded(from: data.backgroundImage ?? "")
        self.descriptionLabel.text = data.description ?? ""
        self.ratinImage.image = UIImage(systemName: "star.fill")
        self.ratinImage.tintColor = .black
        self.ratingLabel.text = "\(data.metacritic ?? 0)"
    }
}
