//
//  ChatHeaderCell.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 12/08/22.
//

import UIKit
import Kingfisher

protocol ChatHeaderCellDelegate: AnyObject {
    func backButtonTapped()
}

class ChatHeaderCell: UITableViewCell {

    // MARK: - Delegate
    
    weak var delegate: ChatHeaderCellDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Actions
    
    @IBAction func backToListButton(_ sender: Any) {
        delegate?.backButtonTapped()
    }
    
    // MARK: - Public methods
    
    func config(with delegate: ChatHeaderCellDelegate, and args: ChatDetailHeaderArgs) {
        userImageView.kf.setImage(with: URL(string: args.userImage))
        userNameLabel.text = args.name
        self.delegate = delegate
    }
}
