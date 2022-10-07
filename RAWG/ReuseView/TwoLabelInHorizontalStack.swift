//  Created by Kevin Maulana on 09/04/22.

import Declayout

final class TwoLabelInHorizontalStack: UIView {
    
    private lazy var hStack = UIStackView.make {
        $0.axis = .horizontal
        $0.edges(to: self)
    }
    
    lazy var titleLabel = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.numberOfLines = 1
        $0.textAlignment = .left
        $0.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        $0.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }
    
    lazy var contentLabel = UILabel.make {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 0
        $0.textAlignment = .right
        $0.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        $0.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func subView() {
        addSubviews([
            hStack.addArrangedSubviews([
                titleLabel,
                contentLabel
            ])
        ])
    }
}
