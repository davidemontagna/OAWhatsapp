//
//  ReceivedMessageCell.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 12/08/22.
//

import UIKit

class ReceivedMessageCell: UITableViewCell {
    
    // MARK: - Outlets

    @IBOutlet weak var triangleImageView: UIImageView!
    @IBOutlet weak var messageBackgroundView: UIView!
    @IBOutlet weak var textMessage: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        triangleImageView.transform = triangleImageView.transform.rotated(by: .pi / -2)
    }

   // MARK: - Public methods
    
    func config(with args: UserChatMessagesArgs) {
        textMessage.text = args.text
        dateLabel.text = args.date
    }
}
