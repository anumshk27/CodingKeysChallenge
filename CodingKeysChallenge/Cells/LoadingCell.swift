//
//  LoadingCell.swift
//  CodingKeysChallenge
//
//  Created by Muhammad Anum on 21/05/2023.
//

import UIKit

class LoadingCell: UITableViewCell {
    
    @IBOutlet weak var loading:UIActivityIndicatorView!
    
    // Set the identifier for the custom cell
    static let identifier = "LoadingCell"
    
    // Returning the xib file after instantiating it
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
}
