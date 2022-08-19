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
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

   // MARK: - Public methods
    
    func config(with args: ChatDetailsMessageArgs) {
        textMessage.text = args.text
        dateLabel.text = args.date
    }
}
