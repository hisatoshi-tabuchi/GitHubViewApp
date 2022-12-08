//
//  RepositoryTableViewCell.swift
//  GitHubViewApp
//
//  Created by Tabuchi Hisatoshi on 2022/12/05.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var favoriteButton: UIButton!
    
    var updateFavoriteStatusClosure: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(name: String, isLiked: Bool, updateFavoriteStatusClosure: @escaping () -> Void) {
        let setIconName = isLiked ? "heart.fill" : "heart"

        nameLabel.text = name
        favoriteButton.setImage(UIImage(systemName: setIconName), for: .normal)
        self.updateFavoriteStatusClosure = updateFavoriteStatusClosure
    }
    
    @IBAction private func tapFavoriteButton(_ sender: Any) {
        updateFavoriteStatusClosure!()
    }
}
