//
//  ChatListCell.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 10/08/22.
//

import UIKit
import Kingfisher

class ChatListCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var imageBackground: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Public methods
    
    func config(with args: ChatArgs) {
        userImageView.kf.setImage(with: URL(string: args.userImage))
        userNameLabel.text = args.name
        lastMessageLabel.text = args.lastMessage
        dateLabel.text = args.date
    }
}
