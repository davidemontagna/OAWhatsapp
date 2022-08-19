//
//  SentLinkMessageCell.swift
//  AOWhatsapp
//
//  Created by Davide Montagna on 12/08/22.
//

import UIKit
import LinkPresentation

class SentLinkMessageCell: UITableViewCell {
    
    // MARK: - Outlets

    @IBOutlet weak var triangleImageView: UIImageView!
    @IBOutlet weak var messageBackgroundView: UIView!
    @IBOutlet weak var textMessage: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Properties
    
    private var provider = LPMetadataProvider()
    private var linkView = LPLinkView()
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

   // MARK: - Public methods
    
    func config(with args: ChatDetailsMessageWithLinkArgs) {
//        textMessage.text = args.text
//        dateLabel.text = args.date
//        errorMessageLabel.isHidden = !args.errorStatus
        
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let url = URL(string: args.url)!

        // Re-create the provider
        provider = LPMetadataProvider()

        
        linkView = LPLinkView(url: url)

        provider.startFetchingMetadata(for: url) { metadata, error in
            guard
                let metadata = metadata,
                error == nil
            else {
                return
            }
            
            // 3
            DispatchQueue.main.async { [weak self] in
                // 4
                guard let self = self else { return }
                
                self.linkView.metadata = metadata
//                self.linkView.sizeToFit()
                //self.sizeToFit()
            }
        }
        // 5
       // self.linkView.frame = CGRect(x: 0, y: 0, width: 245, height: 182)
        self.stackView.addArrangedSubview(self.linkView)
    }
}
