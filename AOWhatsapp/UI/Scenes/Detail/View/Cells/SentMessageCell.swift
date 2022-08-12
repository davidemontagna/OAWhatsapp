//
//  SentMessageCell.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 12/08/22.
//

import UIKit

class SentMessageCell: UITableViewCell {
    
    // MARK: - Outlets

    @IBOutlet weak var messageBackgroundView: UIView!
    @IBOutlet weak var textMessage: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

   // MARK: - Public methods
    
    func config(with args: UserChatMessagesArgs) {
        textMessage.text = args.text
        dateLabel.text = args.date
    }
}
