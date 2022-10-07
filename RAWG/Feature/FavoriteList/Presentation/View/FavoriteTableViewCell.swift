//
//  FavoriteTableViewCell.swift
//  RAWG
//
//  Created by Kevin Maulana on 25/09/22.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var ratinImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundImage.makeRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
