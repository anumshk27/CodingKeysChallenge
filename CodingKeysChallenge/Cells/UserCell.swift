//
//  ImageCell.swift
//  CodingKeysChallenge
//
//  Created by Muhammad Anum on 21/05/2023.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
   
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detailTitle: UILabel!

    // Set the identifier for the custom cell
    static let identifier = "UserCell"
    
    // Returning the xib file after instantiating it
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImage.image = nil
    }
    
    func configure(with image: UIImage?) {
        avatarImage.image = image
    }
    
    func configureCell(user: UsersResponse) {
        avatarImage.sd_setImage(with: URL(string: user.avatar_url ?? ""), placeholderImage: UIImage(named: "defaultImage"))
        avatarImage.setRounded()
        title.text = user.login
        detailTitle.text = user.url
    }
}
